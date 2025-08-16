module("luci.controller.passwall_offline", package.seeall)

function index()
  local fs = require "nixio.fs"
  if not fs.access("/usr/libexec/passwall-offline.sh") then
    entry({"admin","services","passwall-offline"}, call("missing"), _("Passwall Installer"), 10).leaf = true
    return
  end
  entry({"admin","services","passwall-offline"}, template("passwall_offline/index"), _("Passwall Installer"), 10).leaf = true
  entry({"admin","services","passwall-offline","run"}, call("run"), nil).leaf = true
  entry({"admin","services","passwall-offline","log"}, call("log"), nil).leaf = true
end

local LOG = "/tmp/passwall-offline.log"

function missing()
  luci.http.prepare_content("text/plain")
  luci.http.write("Installer script is missing: /usr/libexec/passwall-offline.sh")
end

function run()
  local ver = luci.http.formvalue("ver") or "23.05"
  if ver ~= "23.05" and ver ~= "24.10.2" then ver = "23.05" end
  os.execute(string.format("/usr/libexec/passwall-offline.sh '%s' >%s 2>&1 &", ver, LOG))
  luci.http.prepare_content("application/json")
  luci.http.write('{"ok":true}')
end

function log()
  local fs = require "nixio.fs"
  luci.http.prepare_content("text/plain")
  luci.http.write(fs.readfile(LOG) or "")
end

