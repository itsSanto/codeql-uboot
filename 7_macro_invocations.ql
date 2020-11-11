import cpp

from MacroInvocation mac
where mac.getMacroName() in ["ntohl", "ntohs", "ntohll"]
select mac
