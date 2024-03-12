sub setStackNavigatorReference(ref as object)
    if (m.stackNavigator <> invalid)
        return
    end if

    ' Check that the passed reference is a StackNavigation node
    if (getInterface(ref, "ifSGNodeField") = invalid or ref.subtype() <> "StackNavigator")
        throw "Error: setStackNavigatorReference() requires a StackNavigator node"
    end if

    m.stackNavigator = ref
end sub

function goToScreen(screenName as string, props = invalid as dynamic) as boolean
    if (m.stackNavigator = invalid)
        return false
    end if

    return m.stackNavigator.callFunc("pushScreen", screenName, props)
end function

function goToPreviousScreen(screenName as string, prevScreenProps = invalid as dynamic) as boolean
    if (m.stackNavigator = invalid)
        return false
    end if

    return m.stackNavigator.callFunc("popScreen", screenName, prevScreenProps)
end function
