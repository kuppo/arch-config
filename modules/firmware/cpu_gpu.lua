-- gpu-drivers.lua
local packages = {}
local description_parts = {}

-- CPU microcode
local cpu = dcli.hardware.cpu_vendor()
if cpu == "intel" then
	table.insert(packages, "intel-ucode")
	table.insert(description_parts, "Intel CPU")
elseif cpu == "amd" then
	table.insert(packages, "amd-ucode")
	table.insert(description_parts, "AMD CPU")
end

-- NVIDIA GPU
if dcli.hardware.has_nvidia() then
	dcli.log.info("NVIDIA GPU detected")
	table.insert(description_parts, "NVIDIA GPU")

	-- Proprietary drivers
	table.insert(packages, "nvidia-open")
	table.insert(packages, "nvidia-utils")
	table.insert(packages, "nvidia-settings")
	table.insert(packages, "lib32-nvidia-utils")
	table.insert(packages, "nvidia_prime")

	-- CUDA for compute
	table.insert(packages, "cuda")
end

-- AMD GPU
if dcli.hardware.has_amd_gpu() then
	dcli.log.info("AMD GPU detected")
	table.insert(description_parts, "AMD GPU")

	table.insert(packages, "mesa")
	table.insert(packages, "vulkan-radeon")
	table.insert(packages, "lib32-vulkan-radeon")
	table.insert(packages, "libva-mesa-driver")
end

-- Intel GPU (integrated)
if dcli.hardware.has_intel_gpu() then
	dcli.log.info("Intel GPU detected")
	table.insert(description_parts, "Intel GPU")

	table.insert(packages, "mesa")
	table.insert(packages, "vulkan-intel")
	table.insert(packages, "intel-media-driver")
end

-- Build description
local description = "Hardware drivers"
if #description_parts > 0 then
	description = description .. " (" .. table.concat(description_parts, ", ") .. ")"
end

return {
	description = description,
	packages = packages,
}
