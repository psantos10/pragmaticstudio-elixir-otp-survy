defmodule Servy.HttpServer do
  # server() ->
  #   {ok, LSock} = gen_tcp:listen(5678, [binary, {packet, 0}, {active, false}]),
  #   {ok, Sock} = gen_tcp:accept(LSock),
  #   {ok, Bin} = do_recv(Sock, []),
  #   ok = gen_tcp:close(Sock),
  #   Bin.

  def server do
    {:ok, listen_socket} = :gen_tcp.listen(5678, [:binary, packet: 0, active: false])
    {:ok, socket} = :gen_tcp.accept(listen_socket)
    {:ok, binary} = :gen_tcp.recv(socket, 0)
    :ok = :gen_tcp.close(socket)

    binary
  end
end
