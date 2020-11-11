import cpp

from FunctionCall call,Function f
where call.getTarget() = f and
f.hasName("memcpy")
select f,"a function named memcpy"