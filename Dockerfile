FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8000
CMD ["node", "app.js"]



import heapq
import math

class DStar:
    def __init__(self, grid):
        self.grid = grid
        self.rows = len(grid)
        self.cols = len(grid[0])
        self.km = 0
        self.U = []  # Приоритетная очередь
        self.rhs = [[float('inf')] * self.cols for _ in range(self.rows)]
        self.g = [[float('inf')] * self.cols for _ in range(self.rows)]
        self.backpointers = {}
    
    def heuristic(self, node1, node2):
        """Эвристическая функция (манхэттенское расстояние)"""
        return abs(node1[0] - node2[0]) + abs(node1[1] - node2[1])
    
    def calculate_key(self, node):
        """Вычисление ключа для приоритетной очереди"""
        g_rhs = min(self.g[node[0]][node[1]], self.rhs[node[0]][node[1]])
        return (g_rhs + self.heuristic(node, self.start) + self.km, 
                g_rhs)
    
    def update_vertex(self, u):
        """Обновление вершины"""
        if u != self.goal:
            # Находим минимальное значение rhs среди соседей
            min_rhs = float('inf')
            best_neighbor = None
            
            for neighbor in self.get_neighbors(u):
                if self.grid[neighbor[0]][neighbor[1]] == 0:  # Проверяем проходимость
                    cost = self.g[neighbor[0]][neighbor[1]] + 1
                    if cost < min_rhs:
                        min_rhs = cost
                        best_neighbor = neighbor
            
            self.rhs[u[0]][u[1]] = min_rhs
            if best_neighbor:
                self.backpointers[u] = best_neighbor
        
        # Обновляем очередь
        self.remove_from_queue(u)
        if self.g[u[0]][u[1]] != self.rhs[u[0]][u[1]]:
            heapq.heappush(self.U, (self.calculate_key(u), u))
    
    def remove_from_queue(self, u):
        """Удаление вершины из очереди"""
        self.U = [item for item in self.U if item[1] != u]
        heapq.heapify(self.U)
    
    def get_neighbors(self, node):
        """Получение соседних клеток"""
        neighbors = []
        row, col = node
        
        for dr, dc in [(0, 1), (1, 0), (0, -1), (-1, 0)]:
            r, c = row + dr, col + dc
            if 0 <= r < self.rows and 0 <= c < self.cols:
                neighbors.append((r, c))
        
        return neighbors
    
    class DStar:
    def __init__(self, grid):
        self.U = PriorityQueue()
        self.km = 0
        self.rhs = {}
        self.g = {}
        self.grid = grid

    def calculate_rhs(self, u):
        # Вычисление rhs-значения
        pass


class DStar:
    def __init__(self, grid):
        self.U = PriorityQueue()
        self.km = 0
        self.rhs = {}
        self.g = {}
        self.grid = grid

    def calculate_rhs(self, u):
        # Вычисление rhs-значения
        pass

    def update_vertex(self, u):
        if u != start:
            self.rhs[u] = min(self.cost(u, v) + self.g[v] 
                            for v in self.neighbors(u))
        if u in self.U: self.U.remove(u)
        if self.g[u] != self.rhs[u]:
            self.U.insert(u, self.key(u))

    def compute_shortest_path(self):
        while self.U.top_key() < self.key(s_goal) or self.rhs[s_goal] != self.g[s_goal]:
            u = self.U.pop()
            if self.g[u] > self.rhs[u]:
                self.g[u] = self.rhs[u]
                for s in self.neighbors(u):
                    self.update_vertex(s)
            else:
                self.g[u] = float('inf')
                self.update_vertex(u)
                for s in self.neighbors(u):
                    self.update_vertex(s)

    def key(self, s):
        return [min(self.g[s], self.rhs[s]) + self.h(s) + self.km, 
                min(self.g[s], self.rhs[s])]

    def initialize(self, start, goal):
        """Инициализация алгоритма"""
        self.start = start
        self.goal = goal
        
        # Инициализация цели
        self.rhs[goal[0]][goal[1]] = 0
        self.g[goal[0]][goal[1]] = float('inf')
        heapq.heappush(self.U, (self.calculate_key(goal), goal))
        
        # Первоначальное вычисление пути
        self.compute_shortest_path()
    
    def replan(self, new_obstacles):
        """Перепланирование при изменении карты"""
        self.km += self.heuristic(self.start, self.goal)
        
        # Обновляем вершины с новыми препятствиями
        for obstacle in new_obstacles:
            self.grid[obstacle[0]][obstacle[1]] = 1  # Помечаем как препятствие
            self.update_vertex(obstacle)
            for neighbor in self.get_neighbors(obstacle):
                self.update_vertex(neighbor)
        
        self.compute_shortest_path()
    
    def get_path