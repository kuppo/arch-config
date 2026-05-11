-- Auto-detect hostname for automatic host configuration
-- Falls back to "default" if hostname doesn't match a known host config
local hostname = "default"
if dcli.file.is_file("/etc/hostname") then
	hostname = dcli.util.trim(dcli.file.read("/etc/hostname"))
end
dcli.log.info("Auto-detected host: " .. hostname)

return {
	host = hostname,
}
