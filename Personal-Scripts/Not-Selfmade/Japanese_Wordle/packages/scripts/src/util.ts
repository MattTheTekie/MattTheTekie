import readline from 'readline'

export class ReadLine {
  rl = readline.createInterface(process.stdin, process.stdout)

  async question(s: string) {
    return new Promise<string>((resolve) => {
      this.rl.question(s, resolve)
    })
  }

  close() {
    return this.rl.close()
  }
}
