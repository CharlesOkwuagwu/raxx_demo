defmodule RaxxDemo.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    certfile = Application.app_dir(:raxx_demo, "/priv/localhost.crt")
    keyfile = Application.app_dir(:raxx_demo, "/priv/localhost.key")

    service_options = [
      port: 9999,
      certfile: certfile,
      keyfile: keyfile,
      connections: 10
    ]

    # service_options = [
    #   port: 99,
    #   connections: 10,
    #   certfile: Application.app_dir(:raxx_demo, "/priv/localhost.crt"),
    #   keyfile: Application.app_dir(:raxx_demo, "/priv/localhost.key"),
    #   dhfile: Application.app_dir(:raxx_demo, "/priv/dh-params.pem"),
    #   cacertfile: Application.app_dir(:raxx_demo, "priv/rootCA.pem"),
    #   # versions: [:"tlsv1.2", :"tlsv1.1", :tlsv1],
    #   versions: [:"tlsv1.2"],
    #   secure_renegotiate: true,
    #   client_renegotiation: false,
    #   reuse_sessions: true,
    #   honor_cipher_order: true,
    #   ciphers: ~w(
    #     ECDHE-ECDSA-AES256-GCM-SHA384
    #     ECDHE-ECDSA-AES256-SHA384
    #     ECDHE-ECDSA-AES128-GCM-SHA256
    #     ECDHE-ECDSA-AES128-SHA256
    #     ECDHE-ECDSA-AES256-SHA
    #     ECDHE-ECDSA-AES128-SHA

    #     ECDHE-RSA-AES256-GCM-SHA384
    #     ECDHE-RSA-AES256-SHA384
    #     ECDHE-RSA-AES128-GCM-SHA256
    #     ECDHE-RSA-AES128-SHA256
    #     ECDHE-RSA-AES256-SHA
    #     ECDHE-RSA-AES128-SHA

    #     ECDH-ECDSA-AES256-GCM-SHA384
    #     ECDH-ECDSA-AES256-SHA384
    #     ECDH-ECDSA-AES128-GCM-SHA256
    #     ECDH-ECDSA-AES128-SHA256

    #     DHE-RSA-AES256-GCM-SHA384
    #     DHE-RSA-AES256-SHA256
    #     DHE-DSS-AES256-GCM-SHA384
    #     DHE-DSS-AES256-SHA256
    #     DHE-RSA-AES256-SHA
    #     DHE-DSS-AES256-SHA

    #     DHE-DSS-AES128-GCM-SHA256
    #     DHE-RSA-AES128-GCM-SHA256
    #     DHE-RSA-AES128-SHA256
    #     DHE-DSS-AES128-SHA256
    #     DHE-RSA-AES128-SHA
    #     DHE-DSS-AES128-SHA

    #     AES128-GCM-SHA256
    #     AES128-SHA
    #     DES-CBC3-SHA
    # )c,
    #   eccs: [
    #     :sect571r1,
    #     :sect571k1,
    #     :secp521r1,
    #     :brainpoolP512r1,
    #     :sect409k1,
    #     :sect409r1,
    #     :brainpoolP384r1,
    #     :secp384r1,
    #     :sect283k1,
    #     :sect283r1,
    #     :brainpoolP256r1,
    #     :secp256k1,
    #     :secp256r1,
    #     :sect239k1,
    #     :sect233k1,
    #     :sect233r1,
    #     :secp224k1,
    #     :secp224r1
    #   ]
    # ]

    children = [
      {RaxxDemo.WebServer, [service_options]}
      # supervisor(
      #   Ace.HTTP.Service,
      #   [{RaxxDemo.WebServer, nil}, opts],
      #   name: RaxxDemo.WebSupervisor
      # ),
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: RaxxDemo.Supervisor)
  end
end
