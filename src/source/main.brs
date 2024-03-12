sub main(args)
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    m.global = screen.getGlobalNode()

    stackNavigator = screen.CreateScene("StackNavigator")
    screen.show()

    stackNavigator.callFunc("initialize", args.contentId)

    m.global.addFields({
        navigation: CreateObject("roSGNode", "NavigationController")
    })

    m.global.navigation.callFunc("setStackNavigatorReference", stackNavigator)

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if (msgType = "roSGScreenEvent")
            if (msg.isScreenClosed())
                return
            end if
        end if
    end while
end sub
