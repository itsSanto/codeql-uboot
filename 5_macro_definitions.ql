import cpp

from Macro m
where m.getName() in ["ntohl", "ntohs", "ntohll"]
select m, "a macro named " + m.getName()
