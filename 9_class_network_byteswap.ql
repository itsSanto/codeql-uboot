import cpp

class NetworkBySwap extends Expr {
  NetworkBySwap() {
    exists(MacroInvocation mac |
      mac.getMacroName() in ["ntohl", "ntohs", "ntohll"] and
      this = mac.getExpr()
    )
  }
}

from NetworkBySwap n
select n, "Network byte swap"
