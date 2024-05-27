defmodule PhxdevWeb.Router do
  use PhxdevWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PhxdevWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhxdevWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/taskmgrs", TaskmgrLive.Index, :index
    live "/taskmgrs/new", TaskmgrLive.Index, :new
    live "/taskmgrs/:id/edit", TaskmgrLive.Index, :edit

    live "/taskmgrs/:id", TaskmgrLive.Show, :show
    live "/taskmgrs/:id/show/edit", TaskmgrLive.Show, :edit

  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxdevWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:phxdev, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PhxdevWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
