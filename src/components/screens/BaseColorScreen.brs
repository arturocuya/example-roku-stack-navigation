sub init()
    componentName = m.top.subtype()
    m.top.findNode("titleLabel").text = componentName

    if (componentName = "RedScreen")
        color = "#FF0000"
    else if (componentName = "BlueScreen")
        color = "#0000FF"
    else if (componentName = "GreenScreen")
        color = "#00FF00"
    else
        color = "#000000"
    end if

    m.top.findNode("colorRectangle").color = color
end sub

sub setProps(props as object)
    m.top.findNode("propsLabel").text = "Received props: " + FormatJson(props)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if (not press)
        return false
    end if

    ? "Color Screen key", m.top.subtype(), key

    if (key = "back")
        m.global.navigation.callFunc("goToPreviousScreen")
        return true
    end if

    return false
end function
