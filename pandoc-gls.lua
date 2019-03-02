Str = function(el)
    
    front_p, capital, plural, ac, back_p = el.text:match("(%p*)%((%++)(%^-)(%a+)%)(%p*)")

    if ac then 
        if plural == "^" then
            if capital == "++" then
                new_str = string.format("%s\\Glspl{%s}%s", front_p, ac, back_p)
            else
                new_str = string.format("%s\\glspl{%s}%s", front_p, ac, back_p)
            end
        else
            if capital == "++" then
                new_str = string.format("%s\\Gls{%s}%s", front_p, ac, back_p)
            else
                new_str = string.format("%s\\gls{%s}%s", front_p, ac, back_p)
            end
        end
        return pandoc.RawInline("tex", new_str)
    end
end

