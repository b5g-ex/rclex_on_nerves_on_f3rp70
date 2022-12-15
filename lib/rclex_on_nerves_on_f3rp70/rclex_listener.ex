defmodule RclexOnNervesOnF3rp70.RclexListener do
  def subscribe_message do
    context = Rclex.rclexinit()
    {:ok, node} = Rclex.ResourceServer.create_node(context, 'listener')
    {:ok, subscriber} = Rclex.Node.create_subscriber(node, 'StdMsgs.Msg.String', 'chatter')
    Rclex.Subscriber.start_subscribing([subscriber], context, &sub_callback/1)

    Process.sleep(10000)

    Rclex.Subscriber.stop_subscribing([subscriber])
    Rclex.Node.finish_job(subscriber)
    Rclex.ResourceServer.finish_node(node)
    Rclex.shutdown(context)
  end

  defp sub_callback(msg) do
    recv_msg = Rclex.Msg.read(msg, 'StdMsgs.Msg.String')
    msg_data = List.to_string(recv_msg.data)

    IO.puts("Rclex: received msg: #{msg_data}")
  end
end
