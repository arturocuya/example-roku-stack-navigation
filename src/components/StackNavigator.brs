sub init()
    m.screenMap = {}
    m.screenStack = []
    m.initialized = false
end sub

sub initialize(deeplink = invalid as dynamic)
    if (m.initialized)
        return
    end if

    ? "Initializing StackNavigator..."

    ' Register all the screens you'll make available
    registerScreen("MainScreen")
    registerScreen("RedScreen")
    registerScreen("GreenScreen")
    registerScreen("BlueScreen")

    if (deeplink <> invalid)
        pushScreen(deeplink)
    else
        pushScreen("MainScreen")
    end if

    m.initialized = true

    ' This is required to pass certification.
    ' Specified in section 3.2 of the Roku Certification Criteria.
    ' Reference: https://developer.roku.com/docs/developer-program/certification/certification.md#3-performance
    m.top.signalBeacon("AppLaunchComplete")
end sub

sub registerScreen(id as string, name = invalid as dynamic)
    if (name = invalid)
        name = id
    end if

    screen = m.top.CreateChild(id)
    screen.visible = false
    screen.id = id

    m.screenMap[name] = id
end sub

function pushScreen(name as string, props = invalid as dynamic) as boolean
    currentScreen = m.screenStack.peek()

    ' Avoid pushing the same screen twice
    if (currentScreen = name)
        return false
    end if

    ' Hide the current screen
    if (currentScreen <> invalid)
        m.top.findNode(m.screenMap[currentScreen]).visible = false
    end if

    ' This assumes that all the screens in the map are children of the main scene.
    screenNode = m.top.findNode(m.screenMap[name])

    if (props <> invalid)
        screenNode.callFunc("setProps", props)
    end if

    screenNode.visible = true
    screenNode.setFocus(true)

    m.screenStack.push(name)
    
    return true
end function

function popScreen(prevScreenProps = invalid as dynamic) as boolean
    if (m.screenStack.count() = 0)
        return false
    end if

    removedScreenName = m.screenStack.pop()
    removedScreenId = m.screenMap[removedScreenName]

    ' Hide the removed element
    m.top.findNode(removedScreenId).visible = false

    ' Show the next screen in the stack
    nextScreenName = m.screenStack.peek()
    nextScreenNode = m.top.findNode(m.screenMap[nextScreenName])

    if (prevScreenProps <> invalid)
        nextScreenNode.callFunc("setProps", prevScreenProps)
    end if

    nextScreenNode.visible = true
    nextScreenNode.setFocus(true)

    return true
end function
