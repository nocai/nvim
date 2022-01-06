-- java
local util = require("lspconfig.util")
local sysname = vim.loop.os_uname().sysname

local env = {
	HOME = vim.loop.os_homedir(),
	JAVA_HOME = os.getenv("JAVA_HOME"),
	JDTLS_HOME = os.getenv("JDTLS_HOME"),
	WORKSPACE = os.getenv("WORKSPACE"),
}

local function get_java_executable()
	local executable = env.JAVA_HOME and util.path.join(env.JAVA_HOME, "bin", "java") or "java"
	return sysname:match("Windows") and executable .. ".exe" or executable
end

local function get_jdtls_jar()
	return vim.fn.expand("$JDTLS_HOME/plugins/org.eclipse.equinox.launcher_*.jar")
end

local function get_jdtls_config()
	if sysname:match("Linux") then
		return util.path.join(env.JDTLS_HOME, "config_linux")
	elseif sysname:match("Darwin") then
		return util.path.join(env.JDTLS_HOME, "config_mac")
	elseif sysname:match("Windows") then
		return util.path.join(env.JDTLS_HOME, "config_win")
	else
		return util.path.join(env.JDTLS_HOME, "config_linux")
	end
end

local function get_workspace_dir()
	return env.WORKSPACE and env.WORKSPACE or util.path.join(env.HOME, "workspace")
end

return {
	cmd = {
		get_java_executable(),
		-- "jdtls",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"-Xmx2G",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:/usr/share/java/jdtls/plugins/lombok.jar",
		"-jar",
		get_jdtls_jar(),
		"-configuration",
		get_jdtls_config(),
		"-data",
		get_workspace_dir(),
	},
}
