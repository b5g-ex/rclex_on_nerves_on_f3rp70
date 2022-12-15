defmodule RclexOnNervesOnF3rp70.TeleopKey do
  def start_teleop do
    context = Rclex.rclexinit()
    {:ok, node} = Rclex.ResourceServer.create_node(context, 'teleop_ex')

    {:ok, publisher} =
      Rclex.Node.create_publisher(node, 'GeometryMsgs.Msg.Twist', 'turtle1/cmd_vel')

    teleop_loop(publisher)

    Rclex.Node.finish_job(publisher)
    Rclex.ResourceServer.finish_node(node)
    Rclex.shutdown(context)
  end

  defp teleop_loop(publisher) do
    cmd =
      IO.gets("Input 'W|A|D|X|S' keys to move the turtle. Quit 'Q' to quit: ") |> String.trim()

    if cmd == "q" do
      IO.puts("Quit key was pressed.")
    else
      case twist_get(cmd) do
        nil -> IO.puts("Input key is invalid, so ignored.")
        twist -> twist_pub(twist, publisher)
      end

      # wait for publishing
      Process.sleep(10)
      teleop_loop(publisher)
    end
  end

  defp twist_pub(data, publisher) do
    msg = Rclex.Msg.initialize('GeometryMsgs.Msg.Twist')
    Rclex.Msg.set(msg, data, 'GeometryMsgs.Msg.Twist')
    Rclex.Publisher.publish([publisher], [msg])
  end

  defp twist_get("w") do
    twist_set(2.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  end

  defp twist_get("a") do
    twist_set(0.0, 0.0, 0.0, 0.0, 0.0, 2.0)
  end

  defp twist_get("s") do
    twist_set(0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  end

  defp twist_get("d") do
    twist_set(0.0, 0.0, 0.0, 0.0, 0.0, -2.0)
  end

  defp twist_get("x") do
    twist_set(-2.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  end

  defp twist_get(_) do
    nil
  end

  defp twist_set(linear_x, linear_y, linear_z, angular_x, angular_y, angular_z) do
    %Rclex.GeometryMsgs.Msg.Twist{
      linear: %Rclex.GeometryMsgs.Msg.Vector3{x: linear_x, y: linear_y, z: linear_z},
      angular: %Rclex.GeometryMsgs.Msg.Vector3{x: angular_x, y: angular_y, z: angular_z}
    }
  end
end
