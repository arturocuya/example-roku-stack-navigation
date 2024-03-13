sub init()
    m.propsLabel = m.top.findNode("propsLabel")
    m.buttonGroup = m.top.findNode("buttonGroup")
    m.buttonGroup.buttons = [
        "Go to Red screen",
        "Go to Green screen",
        "Go to Blue screen",
    ]

    m.props = {}

    generateRandomProps()

    m.buttonGroup.observeFieldScoped("buttonSelected", "onButtonSelected")

    m.top.observeField("visible", "handleVisibleChange")
end sub

sub handleVisibleChange()
    if (m.top.visible)
        m.buttonGroup.setFocus(true)
    end if
end sub

sub generateRandomProps()
    keys = ["a", "b", "c", "d", "e"]
    m.props = {}
    m.props[keys[Rnd(5) - 1]] = Rnd(100)
    m.props[keys[Rnd(5) - 1]] = Rnd(100)
    m.props[keys[Rnd(5) - 1]] = Rnd(100)

    m.propsLabel.text = "Props: " + FormatJson(m.props)
end sub

sub onButtonSelected(event as object)
    selectedIndex = event.getData()
    if (selectedIndex = 0)
        m.global.navigation.callFunc("goToScreen", "RedScreen", m.props)
    else if (selectedIndex = 1)
        m.global.navigation.callFunc("goToScreen", "GreenScreen", m.props)
    else if (selectedIndex = 2)
        m.global.navigation.callFunc("goToScreen", "BlueScreen", m.props)
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if (not press)
        return false
    end if

    if (key = "play")
        generateRandomProps()
    end if

    return false
end function
