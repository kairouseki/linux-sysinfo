class MemoryStats(object):
    def __init__(self, filename="/proc/meminfo"):
        data = {}
        for line in open(filename):
            if ":" in line:
                key, value = line.split(":", 1)
                if key in ["Active", "MemTotal", "SwapFree", "SwapTotal"]:
                    data[key] = int(value.split()[0])

        self.total_memory = data["MemTotal"] // 1024
        self.free_memory = (data["MemTotal"] - data["Active"]) // 1024
        self.total_swap = data["SwapTotal"] // 1024
        self.free_swap = data["SwapFree"] // 1024

    @property
    def used_memory(self):
        return self.total_memory - self.free_memory

    @property
    def used_swap(self):
        return self.total_swap - self.free_swap

    @property
    def free_memory_percentage(self):
        return (self.free_memory / float(self.total_memory)) * 100

    @property
    def free_swap_percentage(self):
        if self.total_swap == 0:
            return 0.0
        else:
            return (self.free_swap / float(self.total_swap)) * 100

    @property
    def used_memory_percentage(self):
        return 100 - self.free_memory_percentage

    @property
    def used_swap_percentage(self):
        if self.total_swap == 0:
            return 0.0
        else:
            return 100 - self.free_swap_percentage
