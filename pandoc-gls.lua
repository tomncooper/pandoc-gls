function replace(front_p, ac, back_p, command) 

        new_str = string.format("%s\\%s{%s}%s", front_p, command, ac, back_p)

        return new_str
end

function Str(el)
    
    front_p, capital, plural, ac, back_p = el.text:match(
        "(%p*)%((%++)(%^-)(%a+[_%-]*%a*)%)(%p*)"
    )

    if ac then 
        if plural == "^" then
            if capital == "++" then
                command = "Glspl"
            else
                command = "glspl"
            end
        else
            if capital == "++" then
                command = "Gls"
            else
                command = "gls"
            end
        end
        return pandoc.RawInline("tex", replace(front_p, ac, back_p, command))
    end
end

