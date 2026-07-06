/* ============================================================================
   neural-field.js — Kamilla Gafurzianova Neural Design System
   The signature brand motif: an interconnected digital brain. Nodes (neurons)
   drift through deep purple space; nearby nodes link with synapse lines that
   pulse with travelling data; one rare warm-peach "ignition" node sparks.

   Lightweight 2D canvas. On-brand colours. Honours prefers-reduced-motion
   (renders a single static frame). Reusable across hero + section backdrops.

   USAGE
     <canvas class="neural-field" data-density="0.9" data-spark="true"></canvas>
     <script src="neural-field.js"></script>          // auto-inits every .neural-field
   or programmatically:
     NeuralField.mount(canvasEl, { density: 1, spark: true });

   data-* options:  density (0.4–1.6) · spark ("true"/"false") · interactive ("true")
   ============================================================================ */
(function () {
  'use strict';

  var PALETTE = [
    { core: '#f8eefc', glow: 'rgba(199,92,110,0.9)' },   // pale-pink bright synapse
    { core: '#c75c6e', glow: 'rgba(199,92,110,0.85)' },  // bordeaux / wine
    { core: '#d9b8f5', glow: 'rgba(217,184,245,0.85)' }, // lilac (brightened)
    { core: '#924bb2', glow: 'rgba(146,75,178,0.8)' },   // muted violet
  ];
  var SPARK = { core: '#ffc8a6', glow: 'rgba(246,177,135,0.95)' };
  var LINK = '217,184,245';   // lilac rgb for synapse lines
  var LINK_HOT = '199,92,110'; // bordeaux rgb for active synapses

  var reduce = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  function rand(a, b) { return a + Math.random() * (b - a); }

  function NeuralField(canvas, opts) {
    opts = opts || {};
    this.canvas = canvas;
    this.ctx = canvas.getContext('2d');
    this.density = parseFloat(opts.density != null ? opts.density : canvas.dataset.density) || 1;
    this.spark = (opts.spark != null ? opts.spark : canvas.dataset.spark) !== 'false';
    this.interactive = (opts.interactive != null ? opts.interactive : canvas.dataset.interactive) === 'true';
    this.mouse = { x: -9999, y: -9999 };
    this.nodes = [];
    this.t = 0;
    this._resize = this.resize.bind(this);
    window.addEventListener('resize', this._resize);
    if (this.interactive) {
      canvas.addEventListener('pointermove', function (e) {
        var r = canvas.getBoundingClientRect();
        this.mouse.x = e.clientX - r.left; this.mouse.y = e.clientY - r.top;
      }.bind(this));
      canvas.addEventListener('pointerleave', function () { this.mouse.x = this.mouse.y = -9999; }.bind(this));
    }
    this.resize();
    if (reduce) { this.draw(); }
    else { this.loop = this.loop.bind(this); requestAnimationFrame(this.loop); }
  }

  NeuralField.prototype.resize = function () {
    var dpr = Math.min(window.devicePixelRatio || 1, 2);
    var w = this.canvas.clientWidth || this.canvas.parentNode.clientWidth || 800;
    var h = this.canvas.clientHeight || this.canvas.parentNode.clientHeight || 600;
    this.canvas.width = w * dpr; this.canvas.height = h * dpr;
    this.ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    this.w = w; this.h = h;
    this.linkDist = Math.min(w, h) * 0.34 + 110;
    var count = Math.round((w * h) / 7600 * this.density);
    count = Math.max(30, Math.min(220, count));
    this.nodes = [];
    for (var i = 0; i < count; i++) {
      var isSpark = this.spark && i === Math.floor(count / 2);
      this.nodes.push({
        x: rand(0, w), y: rand(0, h),
        vx: rand(-0.13, 0.13), vy: rand(-0.13, 0.13),
        r: isSpark ? rand(3.0, 4.0) : rand(1.1, 3.0),
        pal: isSpark ? SPARK : PALETTE[Math.floor(Math.random() * PALETTE.length)],
        spark: isSpark,
        phase: rand(0, Math.PI * 2),
        pulse: rand(0.6, 1.6),
      });
    }
  };

  NeuralField.prototype.draw = function () {
    var ctx = this.ctx, n = this.nodes, t = this.t, N = n.length;
    ctx.clearRect(0, 0, this.w, this.h);
    ctx.globalCompositeOperation = 'lighter';

    // track each node's link count + nearest neighbour so nothing floats unconnected
    var linked = new Array(N); for (var z = 0; z < N; z++) linked[z] = 0;
    var nearI = new Array(N); var nearD = new Array(N);
    for (var z2 = 0; z2 < N; z2++) { nearI[z2] = -1; nearD[z2] = Infinity; }

    function drawLink(a, b, d, max, hot, idx) {
      var alpha = (1 - d / max);
      var travel = (Math.sin(t * 0.6 + idx) + 1) / 2; // data travelling along line
      ctx.strokeStyle = 'rgba(' + (hot ? LINK_HOT : LINK) + ',' + (alpha * (hot ? 0.55 : 0.34) + 0.05).toFixed(3) + ')';
      ctx.lineWidth = hot ? 1.1 : 0.7;
      ctx.beginPath(); ctx.moveTo(a.x, a.y); ctx.lineTo(b.x, b.y); ctx.stroke();
      if (alpha > 0.45) {
        var px = a.x + (b.x - a.x) * travel, py = a.y + (b.y - a.y) * travel;
        ctx.fillStyle = 'rgba(' + (hot ? LINK_HOT : LINK) + ',' + (alpha * 0.85).toFixed(3) + ')';
        ctx.beginPath(); ctx.arc(px, py, hot ? 1.5 : 1.0, 0, 6.283); ctx.fill();
      }
    }

    // primary pass: connect every pair within reach
    for (var i = 0; i < N; i++) {
      for (var j = i + 1; j < N; j++) {
        var a = n[i], b = n[j];
        var dx = a.x - b.x, dy = a.y - b.y;
        var d = Math.sqrt(dx * dx + dy * dy);
        if (d < nearD[i]) { nearD[i] = d; nearI[i] = j; }
        if (d < nearD[j]) { nearD[j] = d; nearI[j] = i; }
        if (d < this.linkDist) {
          linked[i]++; linked[j]++;
          drawLink(a, b, d, this.linkDist, a.spark || b.spark, i + j);
        }
      }
    }

    // connectivity guarantee: any node with no link gets wired to its nearest neighbour
    for (var c = 0; c < N; c++) {
      if (linked[c] === 0 && nearI[c] >= 0) {
        var nb = n[nearI[c]];
        drawLink(n[c], nb, Math.min(nearD[c], this.linkDist * 0.99), this.linkDist, n[c].spark || nb.spark, c);
      }
    }

    // nodes (neurons) with glow
    for (var k = 0; k < n.length; k++) {
      var p = n[k];
      var pulse = reduce ? 1 : (0.7 + 0.3 * Math.sin(t * p.pulse + p.phase));
      var rad = p.r * (p.spark ? 1.25 : 1) * (0.9 + 0.25 * pulse);
      var glowR = rad * (p.spark ? 11 : 8);
      var g = ctx.createRadialGradient(p.x, p.y, 0, p.x, p.y, glowR);
      g.addColorStop(0, p.pal.glow);
      g.addColorStop(0.35, 'rgba(' + (p.spark ? '246,177,135' : '217,184,245') + ',' + (0.30 * pulse).toFixed(3) + ')');
      g.addColorStop(1, 'rgba(0,0,0,0)');
      ctx.fillStyle = g;
      ctx.beginPath(); ctx.arc(p.x, p.y, glowR, 0, 6.283); ctx.fill();
      ctx.fillStyle = p.pal.core;
      ctx.beginPath(); ctx.arc(p.x, p.y, rad, 0, 6.283); ctx.fill();
    }
    ctx.globalCompositeOperation = 'source-over';
  };

  NeuralField.prototype.loop = function () {
    this.t += 0.016;
    var n = this.nodes, w = this.w, h = this.h;
    for (var i = 0; i < n.length; i++) {
      var p = n[i];
      p.x += p.vx; p.y += p.vy;
      if (this.interactive) {
        var dx = p.x - this.mouse.x, dy = p.y - this.mouse.y;
        var d2 = dx * dx + dy * dy;
        if (d2 < 14000) { var f = (14000 - d2) / 14000 * 0.6; p.x += dx / Math.sqrt(d2 + 1) * f; p.y += dy / Math.sqrt(d2 + 1) * f; }
      }
      if (p.x < -20) p.x = w + 20; if (p.x > w + 20) p.x = -20;
      if (p.y < -20) p.y = h + 20; if (p.y > h + 20) p.y = -20;
    }
    this.draw();
    requestAnimationFrame(this.loop);
  };

  var API = {
    mount: function (canvas, opts) { return new NeuralField(canvas, opts); },
    initAll: function (root) {
      (root || document).querySelectorAll('canvas.neural-field').forEach(function (c) {
        if (!c.__neural) c.__neural = new NeuralField(c);
      });
    }
  };
  window.NeuralField = API;

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function () { API.initAll(); });
  } else { API.initAll(); }
})();
