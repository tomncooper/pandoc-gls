function replace(front, ac, back, command) 

    apostrophe, rest = string.match(back, "(%'*)(%g+)")

    if apostrophe == "'" then
        back = string.format("\\textquotesingle %s", rest)
    end

    new_str = string.format("%s\\%s{%s}%s", front, command, ac, back)

    return new_str
end

function Str(el)
    
    front, capital, plural, ac, back = el.text:match(
        "(%p*)%(([%+%-]+)(%^-)(%a+[_%-]*%a*)%)(%g*)"
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
        return pandoc.RawInline("tex", replace(front, ac, back, command))
    end
end

