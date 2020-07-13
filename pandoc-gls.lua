function replace(front, ac, back, command) 

    new_str = string.format("%s\\%s{%s}%s", front, command, ac, back)

    return new_str
end

function Str(el)
    
    front, capital, plural, ac, apostrophe, back = el.text:match(
        "(%g*)%(([%+%-]+)(%^-)(%w+[_%-]*%w*)%)([%\u{0027}%\u{2019}]*)(%g*)"
    )

    if ac ~= "" then 
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

        if apostrophe == "\u{0027}" or apostrophe == "\u{2019}" then
            if back ~= "" then 
                back = string.format("'%s", back)
            else
                back = "\\textquotesingle\\space"
            end
        end

        return pandoc.RawInline("tex", replace(front, ac, back, command))
    end
end

