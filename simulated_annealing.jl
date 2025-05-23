using Random

# 定义模拟退火算法函数
function simulated_annealing(f, x0; T0=100.0, T_min=1e-8, alpha=0.99, max_iter=10000)
    current_x = x0           # 当前解
    current_f = f(current_x) # 当前目标函数值
    best_x = current_x       # 记录历史最优解
    best_f = current_f
    T = T0                   # 初始温度

    for i in 1:max_iter
        # 产生新解：在当前解附近随机采样（这里随机步长在 [-1,1] 之间）
        new_x = current_x + (rand()*2 - 1)
        new_f = f(new_x)
        
        # 判断是否接受新解
        if new_f < current_f || rand() < exp((current_f - new_f) / T)
            current_x = new_x
            current_f = new_f
            # 如果是更优解，则记录下来
            if current_f < best_f
                best_x = current_x
                best_f = current_f
            end
        end
        
        # 降温（指数降温）
        T *= alpha
        if T < T_min
            break
        end
    end

    return best_x, best_f
end

# 定义目标函数
# f(x) = x^2 + 3x + 2
f(x) = abs(x - 3) + 0.1 * sin(5x)

# 初始解可以选一个较远的点
x0 = 0.0

# 调用模拟退火算法
opt_x, opt_val = simulated_annealing(f, x0; T0=100.0, T_min=1e-8, alpha=0.99, max_iter=10000)
println("找到的最优解: x = $opt_x, f(x) = $opt_val")
