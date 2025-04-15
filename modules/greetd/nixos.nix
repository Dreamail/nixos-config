{ user, ... }:
{
  services.greetd = {
    enable = true;
    vt = 1;
    settings = {
      default_session = {
        user = user.name;
        command = "uwsm start default";
      };
      initial_session = {
        user = user.name;
        command = "uwsm start default";
      };
    };
  };
}
