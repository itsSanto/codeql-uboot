import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NetworkBySwap extends Expr {
  NetworkBySwap() {
    exists(MacroInvocation mac |
      mac.getMacroName().regexpMatch("ntoh(s|l|ll)") and
      this = mac.getExpr()
    )
  }
}

class Config extends TaintTracking::Configuration {
  Config() { this = "Config: this name doesn't matter" }

  override predicate isSource(DataFlow::Node source) { source.asExpr() instanceof NetworkBySwap }

  override predicate isSink(DataFlow::Node sink) {
    exists(FunctionCall c | c.getTarget().getName() = "memcpy" and sink.asExpr() = c.getArgument(2))
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"
