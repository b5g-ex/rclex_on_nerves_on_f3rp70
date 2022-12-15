defmodule RclexOnNervesOnF3rp70.RclexTalker do
  def publish_message do
    context = Rclex.rclexinit()
    {:ok, node} = Rclex.ResourceServer.create_node(context, 'talker')
    {:ok, publisher} = Rclex.Node.create_publisher(node, 'StdMsgs.Msg.String', 'chatter')

    # This sleep is essential for now
    # see Issue https://github.com/rclex/rclex/issues/212
    Process.sleep(100)

    {:ok, timer} =
      Rclex.ResourceServer.create_timer(&pub_callback/1, publisher, 1000, 'continus_timer')

    Process.sleep(10000)

    Rclex.ResourceServer.stop_timer(timer)
    Rclex.Node.finish_job(publisher)
    Rclex.ResourceServer.finish_node(node)
    Rclex.shutdown(context)
  end

  defp pub_callback(publisher) do
    msg = Rclex.Msg.initialize('StdMsgs.Msg.String')
    data = "Hello World from Rclex!"
    msg_struct = %Rclex.StdMsgs.Msg.String{data: String.to_charlist(data)}
    Rclex.Msg.set(msg, msg_struct, 'StdMsgs.Msg.String')

    IO.puts("Rclex: Publishing: #{data}")
    Rclex.Publisher.publish([publisher], [msg])
  end
end
