# CoDDA

复制本实验时，需要复制整个code文件夹，请不要破坏code文件夹内部的文件树状结构，否则程序将会无法正常运行。
复制本实验时，需要复制整个code文件夹，请不要破坏code文件夹内部的文件树状结构，否则程序将会无法正常运行。
复制本实验时，需要复制整个code文件夹，请不要破坏code文件夹内部的文件树状结构，否则程序将会无法正常运行。

CoDDA是本次实验的主要算法
运行环境: Matlab 2015b

·点击CoDDA\start_all.m文件运行CoDDA算法
在执行前建议输入命令 warning off 以关闭警告

·目前实现了strike，football，livejournal三个数据集
需要那个实验集就取消 %% xxx实验集所涉及的代码注释并运行即可(在start_all文件中)

·实验聚类结果储存在CoDDA目录下的cls.txt文件中，按照1-n的顺序存储各个点所属的社区。注意：聚类结果值存储最后一次。

·在具体的实验文件中，即start_strike.m, start_football.m, start_livejournal.m三个文件，可以调节以下参数
	·maxTimes 实验迭代次数

	另外，执行哪些实验也是可选择的。使用开关进行管理。
	1 = on
	0 = off
	·S_shuffle 跳数阈值实验 
	·sigema_shuffle 衰减因子实验
	·T_shuffle 稀疏自编码器层数实验
	·beta_shuffle 惩罚因子权重实验
	·Lambda_shuffle 权重衰减项

	其他参数命名：
	·k  % 社区个数
	·T  % 深度稀疏自动编码器的层数
	·d  % 每层的节点数

	·S  % 跳数阈值
	·sigema % 衰减因子

	·minS % 最小跳数阈值
	·maxS % 最大跳数阈值
	·maxSTimes % 跳数阈值迭代次数

	·minSigema % 最小衰减因子的十倍
	·maxSigema % 最大衰减因子的十倍
	·maxSigemaTimes % 衰减因子迭代次数


·每个实验文件start_strike.m, start_football.m, start_livejournal.m都会进行两轮实验，每轮实验都是一次完整的过程，但是每轮实验中执行哪些实验是可以选择的。可以自行更改上面的参数。但是注意，第二轮实验之可以更改 执行实验开关，以及迭代次数。但是实验参数无法修改,需要使用第一轮实验的输出参数作为第二轮的输入参数。


文件夹dataset保存了实验数据。
	·data_strike文件夹中，strike.txt 为邻接矩阵，strikecoordinate.txt为数据集的点坐标，用于显示Matlab图像，realresult.txt为真实社区，strike.paj可以使用pajek可视化软件进行可视化。
	·data_football文件夹中，football_adjacency.txt 为邻接矩阵，football_coordinate.txt为数据集的点坐标，用于显示Matlab图像，football_community.txt为真实社区，其他文件用于pajek可视化软件进行可视化。
	·data_livejournal文件夹中，lj_ade.txt是邻接矩阵，lj_coordinate.txt 为数据集的点坐标，用于显示Matlab图像，lj_coms.txt为真实社区，注意，本实验集是由斯坦福大学提供，网址为http://snap.stanford.edu./data/com-LiveJournal.html 本次实验选取其中最大的8个社区的 6368 个节点进行聚类，其中big.dataset文件为整个livejournal实验数据集。
	·（未参加本次实验）data_orkut文件夹中，orkut_adj.txt是邻接矩阵， orkut_coms.txt是真实社区。网址为http://snap.stanford.edu./data/com-Orkut.html


文件夹mit_network_analysis_tools是麻省理工学院提供的一个工具包，网址为http://strategic.mit.edu/downloads.php?page=matlab_networks
文件夹LPA是LPA算法的Matlab实现，基于2015b版本
