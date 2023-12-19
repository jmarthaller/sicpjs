const fs = require('fs');

// let s, stack;

// const D = {
//     N: 0,
//     S: 1,
//     E: 2,
//     W: 3
// }

// const dir = [
//     {x: 0, y: -1},
//     {x: 0, y: 1},
//     {x: 1, y: 0},
//     {x: -1, y: 0},
// ]

// const getLinks = (v, x, y) => {
//     switch (v) {
//         case '|': return [D.S, D.N];
//         case '-': return [D.W, D.E];
//         case 'L': return [D.N, D.E];
//         case 'J': return [D.N, D.W];
//         case '7': return [D.S, D.W];
//         case 'F': return [D.S, D.E];
//         case 'S': s = {x: x, y: y}; return [];
//     }
//     return [];
// }

// let input = fs.readFileSync('day10.txt', 'utf-8');
// let map = input.split("\n").map((line, y) => line.split('').map((v, x) => ({
//     v: v,
//     links: getLinks(v, x, y)
// })));

// // determine the start pipe
// if (s.x > 0 && map[s.y][s.x-1].links.includes(D.E)) map[s.y][s.x].links.push(D.W);
// if (s.x < map[0].length-1 && map[s.y][s.x+1].links.includes(D.W)) map[s.y][s.x].links.push(D.E);
// if (s.y > 0 && map[s.y-1][s.x].links.includes(D.S)) map[s.y][s.x].links.push(D.N);
// if (s.y < map.length-1 && map[s.y+1][s.x].links.includes(D.N)) map[s.y][s.x].links.push(D.S);

// stack = [{p: s, dist: 0}];

// // flood fill along the pipe
// while (n = stack.shift()) {
//     if (map[n.p.y][n.p.x].dist !== undefined && map[n.p.y][n.p.x].dist <= n.dist) continue;
//     map[n.p.y][n.p.x].dist = n.dist;
//     map[n.p.y][n.p.x].links.forEach(d => stack.push({
//         p: {x: n.p.x + dir[d].x, y: n.p.y + dir[d].y},
//         dist: n.dist+1
//     }))
// }

// console.log('p1', Math.max(...map.flat().map(p => p.dist === undefined ? 0 : p.dist)));

// // p2: construct a real maze, where pipes are walls
// let maze = Array(map.length*3), mazeDist = Array(map.length*3);

// map.forEach((row, y) => row.forEach((v, x) => {
//     let submap = [
//         [0, 0, 0],
//         [0, 0, 0],
//         [0, 0, 0]];

//     if (v.dist === undefined) submap[1][1] = 2; else {
//         submap[1][1] = 1; // impassabru
//         v.links.forEach(d => submap[1 + dir[d].y][1 + dir[d].x] = 1)
//     }

//     // copy submap into maze
//     for (let i = 0; i <= 2; i++) {
//         if (maze[y*3+i] === undefined) {
//             maze[y*3+i] = Array(map[0].length*3);
//             mazeDist[y*3+i] = Array(map[0].length*3);
//         }
//         for (let j = 0; j <= 2; j++) maze[y*3+i][x*3+j] = submap[i][j];
//     }
// }))

// stack = [];

// map.forEach((row, y) => row.forEach((v, x) => {
//     if ((y*x == 0 || y == map.length-1 || x == map[0].length-1) && map[y][x].dist === undefined) stack.push({p: {x: x*3, y: y*3}, dist: 0});
// }))

// // flood fill from the not-my-pipe map borders
// while (n = stack.shift()) {
//     if (maze[n.p.y] === undefined || maze[n.p.y][n.p.x] === undefined || maze[n.p.y][n.p.x] == 1) continue;
//     if (mazeDist[n.p.y][n.p.x] !== undefined && mazeDist[n.p.y][n.p.x] <= n.dist) continue;
//     mazeDist[n.p.y][n.p.x] = n.dist;
//     dir.forEach(d => stack.push({
//         p: {x: n.p.x + d.x, y: n.p.y + d.y},
//         dist: n.dist+1
//     }))
// }

// console.log('p2', map.map((row, y) => row.reduce((a, v, x) => a + (v.dist === undefined && mazeDist[y*3][x*3] === undefined ? 1 : 0), 0)).reduce((a, v) => a+v, 0));

// // let's draw the thing
// const canvas = document.getElementById('root'), ctx = canvas.getContext('2d');
// const zoom = 2;

// canvas.width = maze[0].length*zoom;
// canvas.height = maze.length*zoom;

// maze.forEach((row, y) => row.forEach((v, x) => {
//     if (v == 0) return true;
//     ctx.fillStyle = (v == 1 ? '#000' : (mazeDist[y][x] === undefined ? '#f00' : '#00f' ));
//     ctx.fillRect(x*zoom, y*zoom, zoom, zoom);
// }))

// Day 16
// (function() {
// 	let lines = document.body.textContent.trim().split('\n');
// 	let n = 0;

// 	function go(dt=50) {
// 		let id = ++n;
// 		let energised = 0;
// 		let done = false;

// 		document.body.innerHTML = '';
// 		let div = document.createElement('div');
// 		let title = document.createElement('h1');
// 		let i = 0;
// 		let spinner = "";
// 		let spinnerUpdate = setInterval(() => {
// 			spinner = "|/-\\"[i++ % 4];
// 		}, 500)
// 		let titleUpdate = setInterval(() => {
// 			title.textContent = done
// 				? `Energised ${energised} tiles in total. All done.`
// 				: `Energised ${energised} tiles so far... ${spinner}`;
// 			if (done || n !== id) {
// 				clearInterval(titleUpdate);
// 				clearInterval(spinnerUpdate);
// 				return;
// 			}
// 		}, Math.max(200, dt));
// 		title.style = `
// 			color: #ffff66;
// 			text-shadow: 0 0 5px #ffff66;
// 		`;
// 		document.body.appendChild(title);
// 		document.body.appendChild(div);
// 		document.body.style = `
// 			background: #0f0f23;
// 		`;
// 		div.style = `
// 			position: relative;
// 			color: #009900;
// 			text-shadow: 0 0 5px #009900;
// 			line-height: 8px;
// 			font-size: 8px;
// 			text-align: center;
// 		`;
// 		let G = lines.map((l, y) => Array.from(l).map((c, x) => {
// 			let s = document.createElement('div');
// 			s.textContent = c == '.' ? '' : c;
// 			s.style = `
// 				overflow: hidden;
// 				width: 8px;
// 				height: 8px;
// 				position: absolute;
// 				top: ${8 * y}px;
// 				left: ${8 * x}px;
// 			`;
// 			div.appendChild(s);
// 			return { elem: s, char: c, seen: 0 };
// 		}));

// 		let seen = new Set();
// 		let todo = 0;

// 		function step(y, x, dy, dx) {
// 			let p = G[y += dy]?.[x += dx];
// 			if (!p || n !== id) {
// 				return;
// 			}
// 			let key = `${x},${y},${dy},${dx}`;
// 			if (!p.seen) {
// 				energised++;
// 			}
// 			if (p.seen++ < 10) {
// 				p.elem.style.setProperty('background', `hsl(60 100% ${10 * p.seen}%)`);
// 			} else if (seen.has(key)) {
// 				return;
// 			}
// 			seen.add(key);

// 			todo++;
// 			let c = p.char;
// 			setTimeout(() => {
// 				let reflect = (c == '\\') - (c == '/');
// 				if (reflect) {
// 					step(y, x, dx*reflect, dy*reflect);
// 				} else if ((c == '|' && dx) || (c == '-' && dy)) {
// 					step(y, x, -dx, dy);
// 					step(y, x, dx, -dy);
// 				} else {
// 					step(y, x, dy, dx);
// 				}
// 				if (!--todo) {
// 					done = true;
// 				}
// 			}, dt);
// 		}

// 		step(0, -1, 0, 1);
// 	}

// 	window.go = go;
// })();

// const fs = require('node:fs');
// let answer = 0;
// try {
//     const input = fs.readFileSync('day16.txt', 'utf8').trim();
//     const grid = input.split("\r\n").map((row) => row.split(""));

//     let starts = [];
//     for(let c = 0; c < grid[0].length; c++) {
//         starts.push({col:c,row:0,dir:180});
//         starts.push({col:c,row:grid.length-1,dir:0});
//     }
//     for(let r = 0; r < grid.length; r++) {
//         starts.push({col:0,row:r,dir:90});
//         starts.push({col:grid[0].length-1,row:r,dir:270});
//     }
//     starts.forEach((start) => {
//         let shift = [];
//         shift[0]   = [-1, 0];
//         shift[90]  = [ 0, 1];
//         shift[180] = [ 1, 0];
//         shift[270] = [ 0,-1];
//         let nodes = new Map();
//         let output = [...Array(grid.length)].map(_=>Array(grid[0].length).fill("."));  
//         let queue = [start];
//         while(queue.length > 0) {
//             let check = queue.pop();
//             let row = check.row;
//             let col = check.col;
//             let dir = check.dir;
//             let key = `${row}/${col}/${dir}`;
//             if(nodes.has(key)) {
//                 //do nothing, already have this
//                 //console.log('Hit mapping',check);
//                 continue;
//             }
//             nodes.set(key, 1);
//             if(row < 0 || row >= grid.length || col < 0 || col >= grid[0].length) {
//                 //out of bounds, end;
//                 //console.log('Out of bounds', check);
//             }
//             else {
//                 let cell = grid[row][col];
//                 let newdirs = [];
//                 output[row][col] = '#';
//                 if(cell == "|" && (dir == 90 || dir == 270)) {
//                     newdirs = [0,180];
//                 }
//                 else if(cell == "-" && (dir == 0 || dir == 180)) {
//                     newdirs = [90,270];
//                 }
//                 else if(cell == "/") {
//                     switch(dir) {
//                         case 0: newdirs = [90]; break;
//                         case 90: newdirs = [0]; break;
//                         case 180: newdirs = [270]; break;
//                         case 270: newdirs = [180]; break;
//                     }
//                 }
//                 else if(cell == "\\") {
//                     switch(dir) {
//                         case 0: newdirs = [270]; break;
//                         case 90: newdirs = [180]; break;
//                         case 180: newdirs = [90]; break;
//                         case 270: newdirs = [0]; break;
//                     }
//                 }
//                 else { //if(cell == ".") {
//                     newdirs = [dir];
//                     //pass through in same direction
//                 }
//                 newdirs.forEach((newdir) => queue.push({col:col+shift[newdir][1],row:row+shift[newdir][0],dir:newdir}));

//             }
//         }
//         //let temp = output.map((row) => row.join("")).join("\n");
//         //console.log(temp);
//         let startanswer = output.flat().filter((x) => x == '#').length;
//         console.log(start,startanswer);
//         answer = Math.max(startanswer, answer);
//     });
// }
// catch(e) {
//     console.error(e);
// }

// console.log("The answer is:", answer);

//RUN FROM adventofcode.com
// let inputs = (await (await fetch("https://adventofcode.com/2023/day/17/input")).text()).trim().split("\n");
// read in day17.txt, then trim and split on the newline character
let inputs = fs.readFileSync('day17.txt', 'utf-8').trim().split("\n");
let graph = {};
let starting_obj = {};
let starting_neighbors;
let best = Infinity;
let part = 1;

//create a graph representing all y,x pos that can be reached vertically (_v) or horizontally (_h) in N_min, N_max turns.
//for example, pos 0,0 doesn't have a single neighbor to its right, it has three: 0,1 0,2 and 0,3. 
//if we decide to go to 0,1 we HAVE to move vertically next.

//set as function to facilitate part 2
function build_graph(range_min, range_max) {
  for (let col = 0; col < inputs.length; col++) {
    for (let row = 0; row < inputs[0].length; row++) {
      //set coordinates as being reachable both vertically and horizontally, as 2 separate coordinates
      graph[col + "," + row + "_v"] = {
        least: Infinity,
        neighbors: {}
      };
      graph[col + "," + row + "_h"] = {
        least: Infinity,
        neighbors: {}
      };
      //check if down neighbors exist 
      for (let i = range_min; i <= range_max; i++) {
        //if they do
        if (inputs[col + i]) {
          //create the key
          graph[col + "," + row + "_v"].neighbors[(col + i) + "," + row + "_h"] = 0;
          //sum the length to get to it
          for (let j = 1; j <= i; j++) {
            graph[col + "," + row + "_v"].neighbors[(col + i) + "," + row + "_h"] += +inputs[col + j][row];
          }
        }
        //repeat the process to go up
        if (inputs[col - i]) {
          graph[col + "," + row + "_v"].neighbors[(col - i) + "," + row + "_h"] = 0;
          for (let j = 1; j <= i; j++) {
            graph[col + "," + row + "_v"].neighbors[(col - i) + "," + row + "_h"] += +inputs[col - j][row];
          }
        }
        //repeat the process to go right
        if (inputs[col][row + i]) {
          graph[col + "," + row + "_h"].neighbors[col + "," + (row + i) + "_v"] = 0;
          for (let j = 1; j <= i; j++) {
            graph[col + "," + row + "_h"].neighbors[col + "," + (row + i) + "_v"] += +inputs[col][row + j];
          }
        }
        //repeat the process to go left
        if (inputs[col][row - i]) {
          graph[col + "," + row + "_h"].neighbors[col + "," + (row - i) + "_v"] = 0;
          for (let j = 1; j <= i; j++) {
            graph[col + "," + row + "_h"].neighbors[col + "," + (row - i) + "_v"] += +inputs[col][row - j];
          }
        }
      }
    }
  }

  //we shallow-copy-merge 0,0_h.neighbors and 0,0_v.neighbors together, as we want to try everything in a single backtracking.
  Object.assign(starting_obj, graph["0,0_h"].neighbors, graph["0,0_v"].neighbors);
  //Begin eval, using every vertical and horizontal neighbors of 0,0
  starting_neighbors = Object.keys(starting_obj);
  for (let i = 0; i < starting_neighbors.length; i++) {
    walk(starting_neighbors[i], starting_obj[starting_neighbors[i]]);
  }
}

//pass the whole neighbor object, and the path length to date
function walk(neighbor, cumul) {
  //if we already made it to this node in a shorter path, no need to proceed
  //we also stop if we already found a solution (vertically or horizontally) that is shorter than the current attempt
  if (cumul >= Math.min(graph[neighbor].least, best)) {
    return;
  }
  //if we made it to the exit (and past the previous if statement), this is the best answer to date.
  if (neighbor.split("_")[0] == "140,140") {
    console.log("Part " + part + " best to date: " + cumul);
    // we set it as best for both directions
    best = cumul;
    //let's keep trying other solutions
    return;
  }
  //else save as shortest path to node so far
  graph[neighbor].least = cumul;
  //we reached a node in the shortest path to date. we will try all possible directions from it.  
  let n = Object.keys(graph[neighbor].neighbors);
  for (let i = 0; i < n.length; i++) {
    walk(n[i], cumul + graph[neighbor].neighbors[n[i]]);
  }
  return;
}

//build graph
build_graph(1, 3);

//because we print stuff as we iterate to show progress, we save p1 answer for later
let answer_p1 = "part " + part + " answer: " + best;
part++;
graph = {};
starting_obj = {};
best = Infinity;
//for part 2, we are simply going to change the neighbor ranges
build_graph(4, 10);
console.log(answer_p1);
console.log("part " + part + " answer: " + best);