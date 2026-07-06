/* Portfolio / interactive-CV UI kit — SECTIONS. Pairs with PortfolioAtoms.jsx + ../_shared.css. */

const Section = ({ id, n, kicker, title, intro, children, style }) => (
  <section id={id} className="kg-anim" style={{ maxWidth: 'var(--measure)', margin: '0 auto', padding: '64px 32px', ...style }}>
    {(n || kicker) && (
      <div style={{ display: 'flex', alignItems: 'center', gap: 14, marginBottom: 10 }}>
        {n && <span style={{ fontFamily: 'var(--font-mono)', fontSize: 13, color: 'var(--accent-primary)', fontWeight: 600 }}>{n}</span>}
        {kicker && <Kicker>{kicker}</Kicker>}
        <span className="synapse" style={{ maxWidth: 90 }} />
      </div>
    )}
    {title && <h2 style={{ fontSize: 'var(--fs-h2)', maxWidth: 760 }}>{title}</h2>}
    {intro && <p className="lead" style={{ marginTop: 14, maxWidth: 680 }}>{intro}</p>}
    {children}
  </section>
);

/* ---------- Neural hero ---------- */
const NeuralHero = () => (
  <section style={{ position: 'relative', overflow: 'hidden', minHeight: 620,
    background: 'radial-gradient(120% 100% at 70% 25%, var(--nebula-1) 0%, var(--bg-color) 55%, var(--void) 100%)' }}>
    <canvas className="neural-field" data-density="1" data-spark="true" data-interactive="true"
      style={{ position: 'absolute', inset: 0, width: '100%', height: '100%' }} />
    <div style={{ position: 'relative', zIndex: 2, maxWidth: 'var(--measure)', margin: '0 auto', padding: '96px 32px 80px', display: 'grid', gridTemplateColumns: '1.25fr 0.75fr', gap: 48, alignItems: 'center' }}>
      <div>
        <div style={{ display: 'inline-flex', alignItems: 'center', gap: 9, padding: '7px 13px', borderRadius: 'var(--radius-sm)', border: '1px solid var(--border-strong)', background: 'var(--glass-fill)', backdropFilter: 'var(--backdrop-blur)', marginBottom: 22 }}>
          <Node kind="spark" size="sm" />
          <span className="kicker" style={{ color: 'var(--text-secondary)' }}>AI Implementation Consultant · Olympic Silver Medalist</span>
        </div>
        <h1 className="display" style={{ fontSize: 64, textShadow: 'var(--text-glow)' }}>
          Systems that<br /><span style={{ color: 'var(--accent-primary)' }}>fire together</span>.
        </h1>
        <p className="lead" style={{ margin: '24px 0 0', maxWidth: 520, fontSize: 20 }}>
          I integrate AI into how teams actually work. I connect the tools, people, and
          processes that usually sit in separate rooms. Olympic discipline, applied to implementation.
        </p>
        <div style={{ display: 'flex', gap: 12, marginTop: 32, flexWrap: 'wrap' }}>
          <Btn variant="primary" size="lg" iconRight="arrow-right">See the work</Btn>
          <Btn variant="secondary" size="lg" icon="git-branch">The PPPP method</Btn>
        </div>
        <div style={{ display: 'flex', gap: 30, marginTop: 40, flexWrap: 'wrap' }}>
          {[['6', 'Domains integrated'], ['OLY', 'Olympic silver, sabre'], ['PPPP', 'Signature framework']].map(([v, l]) => (
            <div key={l} style={{ display: 'flex', flexDirection: 'column', gap: 3 }}>
              <span style={{ fontFamily: 'var(--font-display)', fontSize: 28, fontWeight: 700, color: 'var(--accent-secondary)' }}>{v}</span>
              <span style={{ fontSize: 12, color: 'var(--text-muted)', fontFamily: 'var(--font-mono)', textTransform: 'uppercase', letterSpacing: '0.08em' }}>{l}</span>
            </div>
          ))}
        </div>
      </div>
      <div className="panel" style={{ padding: 22 }}>
        <Kicker>Currently integrating</Kicker>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 14, marginTop: 16 }}>
          {[['ai', 'AI workflows into BizOps'], ['education', 'Coaching systems for athletes'], ['community', 'Cross-domain operator network']].map(([d, t]) => (
            <div key={t} style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
              <span style={{ flex: 'none' }}><DomainTag domain={d} /></span>
              <span style={{ fontSize: 14, color: 'var(--text-secondary)' }}>{t}</span>
            </div>
          ))}
        </div>
        <div style={{ height: 1, background: 'var(--border-color)', margin: '18px 0' }} />
        <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
          <span style={{ width: 9, height: 9, borderRadius: '50%', background: 'var(--text-success)', boxShadow: '0 0 12px var(--text-success)' }} />
          <span style={{ fontSize: 13, color: 'var(--text-secondary)' }}>Open to implementation engagements</span>
        </div>
      </div>
    </div>
  </section>
);

/* ---------- About + stats ---------- */
const About = () => (
  <Section id="about" n="01" kicker="About" title="A generalist who connects the rooms most people keep separate.">
    <div style={{ display: 'grid', gridTemplateColumns: '1.3fr 0.7fr', gap: 40, marginTop: 28, alignItems: 'start' }}>
      <div style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
        <p>I spent a career learning that elite performance is never one skill. It is the
          integration of many, rehearsed until they fire as one. I bring that same wiring to
          businesses: mapping where AI, operations, marketing, community, sport, and education
          actually meet, then building the system that makes them compound.</p>
        <p style={{ color: 'var(--text-muted)' }}>The throughline is discipline. The medal is
          proof of a method, not a trophy to wave.</p>
        <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap', marginTop: 4 }}>
          <DomainTag domain="ai" /><DomainTag domain="bizops">BizOps</DomainTag><DomainTag domain="marketing" />
          <DomainTag domain="community" /><DomainTag domain="sport">Sport</DomainTag><DomainTag domain="education" />
        </div>
      </div>
      <div className="panel panel--solid" style={{ padding: 24, display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 22 }}>
        {[['6', 'Domains'], ['1×', 'Olympic silver'], ['5', "P's in the method"], ['∞', 'Connections']].map(([v, l]) => (
          <div key={l} style={{ display: 'flex', flexDirection: 'column', gap: 4 }}>
            <span style={{ fontFamily: 'var(--font-display)', fontSize: 34, fontWeight: 700, color: 'var(--accent-primary)', lineHeight: 1 }}>{v}</span>
            <span style={{ fontSize: 12, color: 'var(--text-muted)', fontFamily: 'var(--font-mono)', textTransform: 'uppercase', letterSpacing: '0.07em' }}>{l}</span>
          </div>
        ))}
      </div>
    </div>
  </Section>
);

/* ---------- PPPP framework (interactive thread + beads) ---------- */
const PPPP_DATA = [
  { id: 'past', label: 'Past', role: 'Evidence', pos: { left: '16%', top: '72%' }, desc: 'What already happened. History, data, prior art, audits. I start from the record, not a guess.' },
  { id: 'present', label: 'Present', role: 'Diagnosis', pos: { left: '40%', top: '46%' }, desc: 'What is true right now. The live state, the constraints, the reality on the ground today.' },
  { id: 'possible', label: 'Possible', role: 'Imagination', pos: { left: '62%', top: '57%' }, desc: 'What could be. The option space, the futures worth designing toward.' },
  { id: 'practice', label: 'Practice', role: 'Execution', pos: { left: '85%', top: '32%' }, desc: 'Repeated, deliberate action that compounds. The part most people skip.' },
];
const PROTOCOL = { id: 'protocol', label: 'Protocol', role: 'Integration', desc: 'The hidden fifth P. Protocol is the thread the other four are strung on. The repeatable process that runs through every bead, holds them in order, and standardizes whatever you string onto it.' };

const PPPPFramework = () => {
  const [active, setActive] = React.useState('protocol');
  const all = [...PPPP_DATA, PROTOCOL];
  const cur = all.find(p => p.id === active);
  const threadLit = active === 'protocol';
  return (
    <Section id="framework" n="02" kicker="Signature framework" title="PPPP. How I move a problem from history to habit."
      intro="Four visible P's, plus a hidden fifth that binds them. Past, Present, Possible and Practice are beads. Protocol is the thread they are strung on.">
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 0.9fr', gap: 36, marginTop: 32, alignItems: 'center' }}>
        {/* diagram */}
        <div style={{ position: 'relative', aspectRatio: '1 / 0.7', background: 'radial-gradient(80% 80% at 50% 50%, var(--nebula-1), transparent 70%)', borderRadius: 'var(--radius-2xl)', border: '1px solid var(--border-hairline)', overflow: 'hidden' }}>
          <svg viewBox="0 0 100 70" style={{ position: 'absolute', inset: 0, width: '100%', height: '100%' }}>
            <path d="M1,60 Q8,57 16,50.4 Q30,40 40,32.2 Q52,38 62,39.9 Q74,32 85,22.4 Q92,19 99,16" fill="none" stroke="var(--p-protocol)" strokeWidth="5" opacity={threadLit ? 0.32 : 0.16} strokeLinecap="round" style={{ transition: 'opacity .25s' }} />
            <path d="M1,60 Q8,57 16,50.4 Q30,40 40,32.2 Q52,38 62,39.9 Q74,32 85,22.4 Q92,19 99,16" fill="none" stroke="var(--p-protocol)" strokeWidth="1.5" strokeLinecap="round" />
            <circle cx="1" cy="60" r="1.4" fill="var(--p-protocol)" /><circle cx="99" cy="16" r="1.4" fill="var(--p-protocol)" />
          </svg>
          {PPPP_DATA.map(p => (
            <button key={p.id} onClick={() => setActive(p.id)} style={{ position: 'absolute', left: p.pos.left, top: p.pos.top, transform: 'translate(-50%,-50%)', background: 'none', border: 'none', cursor: 'pointer', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 7 }}>
              <span style={{ width: active === p.id ? 24 : 18, height: active === p.id ? 24 : 18, borderRadius: '50%', background: `var(--p-${p.id})`, boxShadow: `0 0 ${active === p.id ? 24 : 12}px var(--p-${p.id})`, transition: 'all .25s', border: active === p.id ? '2px solid var(--text-primary)' : '2px solid rgba(255,255,255,0.25)' }} />
              <span style={{ fontFamily: 'var(--font-mono)', fontSize: 10.5, fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.1em', color: active === p.id ? 'var(--text-primary)' : 'var(--text-muted)' }}>{p.label}</span>
            </button>
          ))}
          <button onClick={() => setActive('protocol')} title="Protocol = the thread" style={{ position: 'absolute', left: '4%', top: '12%', background: threadLit ? 'color-mix(in srgb, var(--p-protocol) 18%, transparent)' : 'var(--glass-fill)', border: `1px solid ${threadLit ? 'var(--p-protocol)' : 'var(--border-color)'}`, borderRadius: 'var(--radius-sm)', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 7, padding: '5px 10px', backdropFilter: 'var(--backdrop-blur)' }}>
            <span style={{ width: 9, height: 9, borderRadius: '50%', background: 'var(--p-protocol)', boxShadow: '0 0 12px var(--p-protocol)' }} />
            <span style={{ fontFamily: 'var(--font-mono)', fontSize: 10.5, fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.1em', color: threadLit ? 'var(--p-protocol)' : 'var(--text-muted)' }}>Protocol = thread</span>
          </button>
        </div>
        {/* detail */}
        <div className="panel" style={{ padding: 28, minHeight: 230 }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
            <span style={{ width: 13, height: 13, borderRadius: '50%', background: `var(--p-${cur.id})`, boxShadow: `0 0 14px var(--p-${cur.id})` }} />
            <PBadge p={cur.id}>{cur.role}</PBadge>
          </div>
          <h3 style={{ margin: '18px 0 10px', fontSize: 30, fontFamily: 'var(--font-display)' }}>{cur.label}</h3>
          <p style={{ fontSize: 16 }}>{cur.desc}</p>
          <div style={{ display: 'flex', gap: 7, marginTop: 22, flexWrap: 'wrap' }}>
            {all.map(p => <button key={p.id} onClick={() => setActive(p.id)} className={`pbadge pbadge--${p.id}`} style={{ cursor: 'pointer', opacity: active === p.id ? 1 : 0.5 }}>{p.label}</button>)}
          </div>
        </div>
      </div>
    </Section>
  );
};

/* ---------- Cross-domain skill matrix ---------- */
const DOMAINS = [
  { d: 'ai', label: 'AI', skills: ['Implementation strategy', 'Agent & workflow design', 'Model evaluation'] },
  { d: 'bizops', label: 'BizOps', skills: ['Systems & automation', 'Process protocol', 'Tooling integration'] },
  { d: 'marketing', label: 'Marketing', skills: ['Positioning', 'Content systems', 'Funnel design'] },
  { d: 'community', label: 'Community', skills: ['Operator networks', 'Activation', 'Retention loops'] },
  { d: 'sport', label: 'Sport', skills: ['Performance method', 'Coaching systems', 'Team ops'] },
  { d: 'education', label: 'Education', skills: ['Curriculum design', 'Cohort programs', 'Enablement'] },
  { d: 'research', label: 'Research', skills: ['Evidence synthesis', 'Experiment design', 'Insight to action'] },
];
const SkillMatrix = () => (
  <Section id="skills" n="03" kicker="Cross-domain" title="Seven domains, one operating system."
    intro="The value isn't depth in any single column. It's the wiring between them.">
    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3,1fr)', gap: 16, marginTop: 30 }}>
      {DOMAINS.map(dm => (
        <div key={dm.d} className="panel panel--interactive" style={{ padding: 20 }}>
          <DomainTag domain={dm.d}>{dm.label}</DomainTag>
          <ul style={{ listStyle: 'none', padding: 0, margin: '16px 0 0', display: 'flex', flexDirection: 'column', gap: 10 }}>
            {dm.skills.map(s => (
              <li key={s} style={{ display: 'flex', alignItems: 'center', gap: 10, fontSize: 14, color: 'var(--text-secondary)' }}>
                <Node kind={dm.d === 'ai' ? 'violet' : 'lilac'} size="sm" />{s}
              </li>
            ))}
          </ul>
        </div>
      ))}
    </div>
  </Section>
);

/* ---------- Experience timeline ---------- */
const TIMELINE = [
  { year: 'Now', current: true, role: 'AI Implementation Consultant', org: 'Independent', desc: 'Embedding AI into how organizations operate, connecting tools, teams, and protocol so the whole system compounds.', tags: ['AI', 'BizOps', 'Protocol'] },
  { year: 'Career', role: 'Cross-domain operator', org: 'Sport · Marketing · Community', desc: 'Built and ran systems across coaching, content, and community. The raw material for the PPPP method.', tags: ['Marketing', 'Community', 'Education'] },
  { year: 'Foundation', role: 'Olympic athlete, sabre fencing', org: 'Olympic Games', desc: 'Silver medal. A decade of deliberate practice that taught me how integration and repetition turn into performance.', tags: ['Sport', 'Discipline', 'Practice'] },
];
const ExperienceTimeline = () => (
  <Section id="experience" n="04" kicker="Trajectory" title="From the strip to the system.">
    <div style={{ position: 'relative', marginTop: 34, paddingLeft: 34 }}>
      <div style={{ position: 'absolute', left: 7, top: 6, bottom: 6, width: 2, background: 'linear-gradient(var(--accent-primary), var(--accent-violet), transparent)' }} />
      <div style={{ display: 'flex', flexDirection: 'column', gap: 22 }}>
        {TIMELINE.map((t, i) => (
          <div key={i} style={{ position: 'relative' }}>
            <span style={{ position: 'absolute', left: -34, top: 6, width: 16, height: 16, borderRadius: '50%', background: t.current ? 'var(--accent-primary)' : 'var(--bg-elevated)', border: '2px solid var(--accent-primary)', boxShadow: t.current ? 'var(--glow-magenta)' : 'none' }} />
            <div className="panel" style={{ padding: 22 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 12, flexWrap: 'wrap' }}>
                <span style={{ fontFamily: 'var(--font-mono)', fontSize: 12, color: 'var(--accent-secondary)', textTransform: 'uppercase', letterSpacing: '0.1em' }}>{t.year}</span>
                {t.current && <span className="badge badge--spark">Current</span>}
              </div>
              <h3 style={{ margin: '10px 0 4px', fontSize: 21 }}>{t.role}</h3>
              <div style={{ fontSize: 13, color: 'var(--text-muted)', fontFamily: 'var(--font-mono)' }}>{t.org}</div>
              <p style={{ margin: '12px 0 0', fontSize: 15 }}>{t.desc}</p>
              <div style={{ display: 'flex', gap: 7, marginTop: 16, flexWrap: 'wrap' }}>{t.tags.map(tag => <Chip key={tag}>{tag}</Chip>)}</div>
            </div>
          </div>
        ))}
      </div>
    </div>
  </Section>
);

/* ---------- Selected work (filterable) ---------- */
const WORK = [
  { title: 'AI workflow integration', domain: 'ai', desc: 'Wired generative AI into an operations team\'s daily protocol: drafting, triage, and handoff.', tags: ['Implementation', 'Protocol'] },
  { title: 'BizOps automation backbone', domain: 'bizops', desc: 'Connected disconnected tools into one operating system with standardized process.', tags: ['Systems', 'Automation'] },
  { title: 'Content engine', domain: 'marketing', desc: 'A repeatable content system engineered for reach and consistency across channels.', tags: ['Content', 'Systems'] },
  { title: 'Operator community', domain: 'community', desc: 'Activation and retention loops for a cross-domain network of practitioners.', tags: ['Community', 'Growth'] },
  { title: 'Performance method', domain: 'sport', desc: 'Translated elite coaching systems into a repeatable program for teams.', tags: ['Coaching', 'Method'] },
  { title: 'Cohort curriculum', domain: 'education', desc: 'Designed a cohort program that turns the PPPP method into enablement.', tags: ['Curriculum', 'Enablement'] },
  { title: 'Evidence synthesis', domain: 'research', desc: 'Turned scattered findings into a clear, decision-ready brief that a team could act on.', tags: ['Research', 'Insight'] },
];
const SelectedWork = () => {
  const filters = ['all', 'ai', 'bizops', 'marketing', 'community', 'sport', 'education', 'research'];
  const [f, setF] = React.useState('all');
  const shown = f === 'all' ? WORK : WORK.filter(w => w.domain === f);
  const labelOf = { all: 'All', ai: 'AI', bizops: 'BizOps', marketing: 'Marketing', community: 'Community', sport: 'Sport', education: 'Education', research: 'Research' };
  return (
    <Section id="work" n="05" kicker="Selected work" title="Integration, applied.">
      <div style={{ display: 'flex', gap: 8, margin: '24px 0 26px', flexWrap: 'wrap' }}>
        {filters.map(x => (
          <button key={x} onClick={() => setF(x)} className={x === f ? 'chip chip--filled' : 'chip chip--outlined'} style={{ cursor: 'pointer' }}>{labelOf[x]}</button>
        ))}
      </div>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3,1fr)', gap: 16 }}>
        {shown.map(w => (
          <div key={w.title} className="panel panel--interactive" style={{ padding: 20, display: 'flex', flexDirection: 'column' }}>
            <div style={{ height: 96, borderRadius: 'var(--radius-md)', border: '1px solid var(--border-hairline)', marginBottom: 16, position: 'relative', overflow: 'hidden', background: `radial-gradient(70% 90% at 30% 20%, var(--domain-${w.domain}-bg), transparent), var(--bg-deep)`, display: 'grid', placeItems: 'center' }}>
              <span className={`node node--${w.domain === 'ai' || w.domain === 'research' ? 'violet' : 'lilac'}`} style={{ width: 16, height: 16 }} />
            </div>
            <DomainTag domain={w.domain}>{labelOf[w.domain]}</DomainTag>
            <h3 style={{ margin: '12px 0 6px', fontSize: 18 }}>{w.title}</h3>
            <p style={{ margin: 0, fontSize: 14, color: 'var(--text-secondary)', flex: 1 }}>{w.desc}</p>
            <div style={{ display: 'flex', gap: 7, marginTop: 14, flexWrap: 'wrap' }}>{w.tags.map(t => <Chip key={t}>{t}</Chip>)}</div>
          </div>
        ))}
      </div>
    </Section>
  );
};

/* ---------- Contact ---------- */
const Contact = () => {
  const [sent, setSent] = React.useState(false);
  return (
    <Section id="contact" n="06" kicker="Connect" title="Let's wire it together.">
      <div style={{ display: 'grid', gridTemplateColumns: '0.8fr 1.2fr', gap: 36, marginTop: 30 }}>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 18 }}>
          {[['mail', 'Email', 'hello@kamilla.systems'], ['map-pin', 'Based', 'Remote · global'], ['calendar', 'Availability', 'Implementation engagements']].map(([ic, l, v]) => (
            <div key={l} style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
              <span style={{ width: 42, height: 42, borderRadius: 'var(--radius-md)', display: 'grid', placeItems: 'center', background: 'var(--glass-fill)', border: '1px solid var(--border-color)', color: 'var(--accent-secondary)', flex: 'none' }}><I name={ic} size={18} /></span>
              <div style={{ display: 'flex', flexDirection: 'column' }}>
                <span className="label">{l}</span>
                <span style={{ fontSize: 15, color: 'var(--text-primary)' }}>{v}</span>
              </div>
            </div>
          ))}
        </div>
        <form className="panel" style={{ padding: 26, display: 'flex', flexDirection: 'column', gap: 14 }} onSubmit={e => { e.preventDefault(); setSent(true); }}>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 14 }}>
            <div className="stack" style={{ gap: 6 }}><span className="label">Name</span><input className="field" placeholder="Your name" /></div>
            <div className="stack" style={{ gap: 6 }}><span className="label">Email</span><input className="field" placeholder="you@company.com" /></div>
          </div>
          <div className="stack" style={{ gap: 6 }}><span className="label">What should we connect?</span><textarea className="field" rows="4" placeholder="Tell me where the domains are colliding…" /></div>
          <Btn variant="primary" iconRight={sent ? 'check' : 'send'} type="submit" style={{ alignSelf: 'flex-start' }}>{sent ? 'Signal sent' : 'Send signal'}</Btn>
        </form>
      </div>
    </Section>
  );
};

Object.assign(window, { Section, NeuralHero, About, PPPPFramework, SkillMatrix, ExperienceTimeline, SelectedWork, Contact });
