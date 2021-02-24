class DT {
  // COLORED TEXT WITH NO BACKGROUND
  static void printBlack(var message) {
    print("\x1b[30m$message\x1B[0m");
  }

  static void printRed(var message) {
    print("\x1b[31m$message\x1B[0m");
  }

  static void printGreen(var message) {
    print("\x1B[32m$message\x1B[0m");
  }

  static void printYellow(var message) {
    print("\x1b[33m$message\x1B[0m");
  }

  static void printBlue(var message) {
    print("\x1b[34m$message\x1B[0m");
  }

  static void printMagenta(var message) {
    print("\x1b[35m$message\x1B[0m");
  }

  static void printCryan(var message) {
    print("\x1b[36m$message\x1B[0m");
  }

  static void printWhite(var message) {
    print("\x1b[37m$message\x1B[0m");
  }

  // COLORED BACKGROUNG WITH DEFAULT TEXT COLOR
  static void printBlackBG(var message) {
    print("\x1B[40m$message\x1B[0m");
  }

  static void printRedBG(var message) {
    print("\x1B[41m$message\x1B[0m");
  }

  static void printGreenBG(var message) {
    print("\x1B[42m$message\x1B[0m");
  }

  static void printYellowBG(var message) {
    print("\x1B[43m$message\x1B[0m");
  }

  static void printBlueBG(var message) {
    print("\x1B[44m$message\x1B[0m");
  }

  static void printMagentaBG(var message) {
    print("\x1B[45m$message\x1B[0m");
  }

  static void printCryanBG(var message) {
    print("\x1B[46m$message\x1B[0m");
  }

  static void printWhiteBG(var message) {
    print("\x1B[47m$message\x1B[0m");
  }
}
