pub fn decode_utf8(bytes : Bytes) -> String {
  let converted = Bytes::make(bytes.length() * 4, 0)
  let mut len = 0
  for i = 0; i < bytes.length(); {
    if bytes[i] < 0b10000000 {
      len += converted.set_utf16_char(len, Char::from_int(bytes[i]))
      continue i + 1
    } else if bytes[i] < 0b11100000 && i + 1 < bytes.length() {
      len += converted.set_utf16_char(
        len,
        Char::from_int(
          bytes[i].land(0b11111).lsl(6).lor(bytes[i + 1].land(0b111111)),
        ),
      )
      continue i + 2
    } else if bytes[i] < 0b11110000 && i + 2 < bytes.length() {
      len += converted.set_utf16_char(
        len,
        Char::from_int(
          bytes[i].land(0b1111).lsl(12).lor(bytes[i + 1].land(0b111111).lsl(6)).lor(
            bytes[i + 2].land(0b111111),
          ),
        ),
      )
      continue i + 3
    } else if bytes[i] < 0b11111000 && i + 3 < bytes.length() {
      len += converted.set_utf16_char(
        len,
        Char::from_int(
          bytes[i].land(0b111).lsl(18).lor(bytes[i + 1].land(0b111111).lsl(12)).lor(
            bytes[i + 2].land(0b111111).lsl(6),
          ).lor(bytes[i + 3].land(0b111111)),
        ),
      )
      continue i + 4
    } else {
      break // let it go ~
    }
  }
  converted.sub_string(0, len)
}
