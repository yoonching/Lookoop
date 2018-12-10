# 2018-8-21
# 最小上生成树
# Kruskal算法

# 算法导论 P366
# 数据结构与算法分析 P239
"""G = {
	"v1":{"v2":2,"v3":4,"v4":1},
	"v2":{"v4":3,"v5":10},
	"v3":{"v4":2,"v6":5},
	"v4":{"v5":7,"v6":8,"v7":4},
	"v5":{"v7":6},
	"v6":{"v7":1}
}"""
G = [
	{1:["v1","v2"]},
	{1:["v6","v7"]},
	{2:["v1","v2"]},
	{2:["v3","v4"]},
	{3:["v2","v4"]},
	{4:["v1","v3"]},
	{4:["v4","v7"]},
	{5:["v3","v6"]},
	{6:["v5","v7"]},
	{7:["v4","v5"]},
	{8:["v4","v6"]},
	{10:["v2","v5"]}
]

def Krustal(G):
	"""
	将边按照权值排序
	每次选择一条选中最小的边加入到森林

	暂未实现
	"""
	edgesAc = 0 # 记录已经选找到的最小权值边
	# H = weightSort(G) # 按权值排序边
	H = G
	tree = [] # 存储最小树
	tmp = []

	while edgesAc < len(H):
		s = E.pop(0)
		if s not in tmp:
			tmp.extend
			union(tree, s) # 将边添加到树中
		edgesAc += 1

	return tree



