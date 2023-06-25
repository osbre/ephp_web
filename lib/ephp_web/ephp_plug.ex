defmodule EphpWeb.EphpPlug do
  import Plug.Conn

  alias :ephp, as: Ephp
  alias :ephp_config, as: EphpConfig
  alias :ephp_output, as: EphpOutput
  alias :ephp_context, as: EphpContext
  alias :ephp_parser, as: EphpParser
  # alias :ephp_array, as: EphpArray

  def init(options) do
    # initialize options
    options
  end

  def call(conn, _opts) do
    path = "lib/ephp_web/templates/index.php"
    filename = "index.php"

    content = path
      |> File.read!()
      |> EphpParser.parse()
      |> Macro.escape()

    EphpConfig.start_link(Application.get_env(:php, :php_ini, "php.ini"))
    EphpConfig.start_local()

    {:ok, ctx} = Ephp.context_new(filename)

    {:ok, output} = EphpOutput.start_link(ctx, false)
    EphpContext.set_output_handler(ctx, output)

    try do
      Ephp.eval(filename, ctx, content) # It fails here with "no case clause matching: {:EXIT ..."
    catch
      {:ok, :die} -> :ok
    end

    out = EphpContext.get_output(ctx)
    EphpContext.destroy_all(ctx)
    EphpConfig.stop_local

    dbg out

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, "Hello world") # TODO: send output as a response, in a simple way for testing
  end
end
