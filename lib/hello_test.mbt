test {
  let str = Bytes::make(14, 0)
  str[0] = 0xe4
  str[1] = 0xb8
  str[2] = 0xad
  str[3] = 0xe6
  str[4] = 0x96
  str[5] = 0x87
  str[6] = 0x61
  str[7] = 0x73
  str[8] = 0x64
  str[9] = 0x66
  str[10] = 0xf0
  str[11] = 0x9f
  str[12] = 0x98
  str[13] = 0x80
  @assertion.assert_eq(decode_utf8(str), "中文asdf😀")?
}