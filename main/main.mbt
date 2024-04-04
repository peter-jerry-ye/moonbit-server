fn main {
  @wasi.stdout.print("Content-type: text/html\n\n")
  @wasi.stdout.print("Hello, World!\n")
  match @wasi.get_environs() {
    Err(e) => @wasi.stdout.print("Error: " + e.to_string() + "\n")
    Ok(environs) => {
      @wasi.stdout.print("Environment variables:\n")
      environs.iter(fn { bytes => @wasi.stdout.println(@lib.decode_utf8(bytes)) })
    }
  }
}
