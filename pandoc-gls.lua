function replace(front_p, ac, back_p, command) 

        new_str = string.format("%s\\%s{%s}%s", front_p, command, ac, back_p)

        return new_str
end

function Str(el)
    
    front_p, capital, plural, ac, back_p = el.text:match(
        "(%g*)%(([%+%-]+)(%^-)(%a+[_%-]*%a*)%)(%g*)"
    )

    if ac then 
        if plural == "^" then
            if capital == "++" then
                command = "Glspl"
            elseif capital == "+" then
                command = "glspl"
            elseif capital == "-+" then
                command = "Glsentryplural"
            elseif capital == "-" then
                command = "glsentryplural"
            else 
                -- Unknown command string so just return the element unchanged
                return el
            end
        else
            if capital == "++" then
                command = "Gls"
            elseif capital == "+" then
                command = "gls"
            elseif capital == "-+" then
                command = "Glsentryname"
            elseif capital == "-" then
                command = "glsentryname"
            else 
                -- Unknown command string so just return the element unchanged
                return el
            end
        end
        return pandoc.RawInline("tex", replace(front_p, ac, back_p, command))
    end
end

