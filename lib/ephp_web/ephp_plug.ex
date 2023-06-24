defmodule EphpWeb.EphpPlug do
  import Plug.Conn

  alias :ephp, as: Ephp
  # alias :ephp_config, as: EphpConfig
  alias :ephp_output, as: EphpOutput
  alias :ephp_context, as: EphpContext
  alias :ephp_parser, as: EphpParser
  # alias :ephp_array, as: EphpArray

  def init(options) do
    # initialize options
    options
  end

  def call(conn, _opts) do
    {:ok, ctx} = Ephp.context_new()

    content = "Result for <?php echo 4; ?>"
      |> EphpParser.parse()
      |> Macro.escape()

    Ephp.eval(ctx, content)

    {:ok, output} = EphpOutput.start_link(ctx, false)
    EphpContext.set_output_handler(ctx, output)

    out = EphpContext.get_output(ctx)


    dbg out

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello world")
  end
end
