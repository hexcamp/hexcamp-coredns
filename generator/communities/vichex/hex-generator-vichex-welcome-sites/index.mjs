import base32 from 'base32.js'
import { Buffer } from 'buffer'
import { getOriginH3IndexFromUnidirectionalEdge, h3GetBaseCell, h3GetResolution, h3IndexToSplitLong } from "h3-js";
import { parse } from 'csv-parse/sync';
import { readFileSync, writeFileSync } from 'fs';


function urlToHex(url) {
  const decoder = new base32.Decoder({ type: 'rfc4648', lc: true })
  const bytes = decoder.write(url).finalize()
  // console.log('Jim urlToHex', bytes)
  const encodedHex = '8' + Buffer.from(bytes).toString('hex')
  const padded = encodedHex.padEnd(15, 'f')
  // console.log('Jim urlToHex 2', padded)
  return padded
}

function hexToUrl(h3Index) {
  if (!h3Index) return ''
  let trimmed = h3Index.replace(/f*$/, '')
  if (trimmed[0] !== '8') return 'Error'
  if (trimmed.length % 2 === 0) {
    trimmed += 'f'
  }
  const buf = Buffer.from(trimmed.slice(1), 'hex')
  const encoder = new base32.Encoder({ type: 'rfc4648', lc: true })
  // console.log("Jim hexToUrl", h3Index, buf)
  const str = encoder.write(buf).finalize()
  return str
}

// From https://observablehq.com/@nrabinowitz/h3-index-bit-layout?collection=@nrabinowitz/h3
function getIndexDigit(lower, upper, res) {
  const H3_PER_DIGIT_OFFSET = 3;
  const H3_DIGIT_MASK = 7;
  const MAX_H3_RES = 15;
  const UPPER_RES_OFFSET = 11;
  const UPPER_SPLIT_RES = 1;
  const LOWER_SPLIT_RES = H3_PER_DIGIT_OFFSET - UPPER_SPLIT_RES;
  // res < 5 is in the upper bits, with a one-bit offset
  if (res < 5) {
    return (upper >> UPPER_SPLIT_RES + (
      (MAX_H3_RES - UPPER_RES_OFFSET - res) * H3_PER_DIGIT_OFFSET
    )) & H3_DIGIT_MASK;
  }
  // res > 5 is in the lower bits
  if (res > 5) {
    return (lower >> ((MAX_H3_RES - res) * H3_PER_DIGIT_OFFSET)) & H3_DIGIT_MASK;
  }
  // res 5 is annoyingly split across upper and lower
  return ((upper & 1) << 2) + (lower >>> 30);
}

function getDigits(h3Str, resolution) {
  const [lower, upper] = h3IndexToSplitLong(h3Str);
  const digits = [];
  for (let i = 1; i <= resolution; i++) {
    digits.push(
      getIndexDigit(lower, upper, i)
    )
  }
  return digits;
}

function getH3Bits(res, base, digits) {
  // https://observablehq.com/@nrabinowitz/h3-index-bit-layout?collection=@nrabinowitz/h3
  const reserved = 0n;
  const reservedWidth = 1n;
  let acc = reserved;
  const indexMode = 1n;
  const indexModeWidth = 4n;
  acc = (acc << indexModeWidth) + indexMode;
  const modeDependent = 0n;
  const modeDependentWidth = 3n;
  acc = (acc << modeDependentWidth) + modeDependent;
  const resolution = BigInt(res);
  const resolutionWidth = 4n;
  acc = (acc << resolutionWidth) + resolution;
  const baseCell = BigInt(base);
  const baseCellWidth = 7n;
  acc = (acc << baseCellWidth) + baseCell;
  for (let i = 0; i < 15; i++) {
    let digit = 7n;
    if (i < digits.length) {
      digit = BigInt(digits[i]);
    }
    const digitWidth = 3n;
    acc = (acc << digitWidth) + digit;
  }

  return acc
}

function toBytes(big, byteLen) {
  big = (big << 4n) + 15n;
  // console.log('Big2:', big.toString(2))
  let result = new Uint8Array(byteLen);
  let i = 1;
  while (big > 0n) {
    result[byteLen - i] = Number(big % 256n);
    big = big / 256n;
    i += 1;
  }
  return result;
}

function getH3(res, base, digits) {
  const bits = getH3Bits(res, base, digits);
  const bytes = toBytes(bits, 8)
  const byteStr = Buffer.from(bytes).toString('hex')
  return byteStr.slice(0, byteStr.length - 1)
}


/*
const hexId = '6kgvileuk4va'
console.log('HexId:', hexId);
const h3Str = urlToHex(hexId);
console.log('H3:', h3Str);
const resolution = h3GetResolution(h3Str);
console.log('Resolution:', resolution);
const base = h3GetBaseCell(h3Str);
console.log('Base Cell:', base);
const digits = getDigits(h3Str, resolution);
console.log('Digits:', digits.join(', '));

// Reconstruct
const bits = getH3Bits(resolution, base, digits);
console.log('Bits:', bits.toString(2))
const bytes = toBytes(bits, 8)
console.log('Bytes:', Buffer.from(bytes).toString('hex'))
const newH3Str = getH3(resolution, base, digits);
console.log('New H3:', newH3Str)
console.log('New Hex ID:', hexToUrl(newH3Str))
*/

function genSubAllocHex(res, base, digits, childNum) {
  res++;
  const newDigits = [...digits];
  newDigits.push(childNum % 7);
  while (res < 15) {
    res++;
    newDigits.push(res != 15 ? 0 : 0 + Math.floor(childNum / 7));
  }
  const newH3Str = getH3(res, base, newDigits);
  return newH3Str;
}

// https://csv.js.org/parse/api/sync/


let output = 'child_num,hex_id,dns_mapping,notes\n'
const hex_id = 'ikgrw'; // Victoria
const h3Str = urlToHex(hex_id);
console.log('  H3:', h3Str);
const res = h3GetResolution(h3Str);
console.log('  Resolution:', res);
const base = h3GetBaseCell(h3Str);
console.log('  Base Cell:', base);
const digits = getDigits(h3Str, res);
console.log('  Digits:', digits.join(', '));
const children = []
for (let i = 0; i < 7 * 7; i++) {
  const childH3Str = genSubAllocHex(res, base, digits, i);
  const childHexId = hexToUrl(childH3Str);
  console.log('  Child %d: %s, %s', i, childH3Str, childHexId)
  const childRes = h3GetResolution(childH3Str);
  console.log('    Resolution:', childRes);
  const childDigits = getDigits(childH3Str, childRes);
  console.log('    Digits:', childDigits.join(', '));
  const revDigits = [...childDigits].reverse();
  const dnsMapping = revDigits.join('.') + '.20.h3.vichex.ca.';
  console.log('    DNS:', dnsMapping);
  output += `${i},${childHexId},${dnsMapping},\n`;
}
// console.log(output)
writeFileSync('../vichex-welcome-sites.csv', output);
