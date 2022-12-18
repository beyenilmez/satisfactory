function sleep(seconds)
    starttime = computer.millis()
    endtime = (starttime+(seconds*1000))
    while((computer.millis()) < endtime) do
    end
end

function WriteFile(filePath, text, mode)
    if not mode then mode = "w" end
    file = filesystem.open(filePath, mode)
    file:write(text)
    file:close()
end
    
function ReadFile(filePath, chunkSize)
    file = filesystem.open(filePath, "r")
    if filesystem.exists(filePath) and filesystem.isFile(filePath) then
    if not chunkSize then chunkSize = 8192 end
        local content = ""
        while true do
            local read = file:read(chunkSize)
            if not read then break end
            content = content .. read
        end
    file:close()
    return content
    else
        print("[UTILS] [ERROR] There is no file in \"/" .. filePath .. "\"")
        computer.beep()
        computer.stop()
    end
end

function BroadcastFromServer(networkCard, serverUUID, serverPort, sender, broadcastPort, d1, d2, d3, d4, d5)
    if(type(serverUUID) == string) then
        networkCard:send(serverUUID, serverPort, sender, broadcastPort, d1, d2, d3, d4, d5)
        print("[SYSTEM] Packet sent to port " .. serverPort .. " of server with UUID " .. serverUUID)
    else networkCard:broadcast(serverPort, sender, broadcastPort, d1, d2, d3, d4, d5) 
        print("[SYSTEM] Packet broadcasted to port " .. serverPort .. " for server to receive")
    end
    print("[SYSTEM] Sender        : " .. sender)
    print("[SYSTEM] Broadcast Port: " .. broadcastPort)
    print("--------------------------------------------------------------------------------------")
end

function ForwardToPort(networkCard, sender, broadcastPort, d1, d2, d3, d4, d5)
    networkCard:broadcast(broadcastPort, sender, d1, d2, d3, d4, d5)
    print("[SYSTEM] Packet Received From: " .. sender)
    print("[SYSTEM] Packet Forwarding To: Port " .. broadcastPort)
    print("--------------------------------------------------------------------------------------")
end

function ReceiveMessage(networkCard, broadcastPort)
    networkCard:open(broadcastPort)
    local type, receiver, serverUUID, broadcastPort, sender, d1, d2, d3, d4, d5  = event.pull()
    if type == "NetworkMessage" then
    return sender, d1, d2, d3, d4, d5;
    end
end

function StartBeep()
    computer.beep(1)
    sleep(0.085)
    computer.beep(2)
end
    
function ErrorBeep()
    computer.beep(1)
    sleep(0.06)
    computer.beep(0)
    sleep(0.1)
    computer.beep(0)
end
