defmodule RclexOnNervesOnF3rp70.SubPose do
  def start_pose(sub_time) do
    context = Rclex.rclexinit()
    {:ok, node} = Rclex.ResourceServer.create_node(context, 'subpose_ex')
    {:ok, subscriber} = Rclex.Node.create_subscriber(node, 'Turtlesim.Msg.Pose', 'turtle1/pose')

    Rclex.Subscriber.start_subscribing([subscriber], context, &subpose_callback/1)

    IO.puts("Subscribe /turtle1/pose in #{inspect(sub_time)} ms")
    Process.sleep(sub_time)

    Rclex.Node.finish_job(subscriber)
    Rclex.ResourceServer.finish_node(node)
    Rclex.shutdown(context)
  end

  defp subpose_callback(msg) do
    data = Rclex.Msg.read(msg, 'Turtlesim.Msg.Pose')
    IO.puts("=== pose: #{inspect(%{x: data.x, y: data.y})} ===")
    GenServer.cast({:global, :turtle}, {:pose, %{x: data.x, y: data.y}})
  end
end
