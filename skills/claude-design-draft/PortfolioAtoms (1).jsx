/* Portfolio / interactive-CV UI kit — Kamilla Gafurzianova Neural Design System.
   ATOMS + chrome. Cosmetic, reusable recreations. Pairs with ../_shared.css. */

const I = ({ name, size = 16, style }) => <i data-lucide={name} style={{ width: size, height: size, display: 'inline-flex', ...style }} />;

const Kicker = ({ children, style }) => <span className="kicker" style={style}>{children}</span>;

/* The brand mark: an interconnected neural node cluster (circles + synapse lines),
   every node wired to a central peach ignition hub AND to its neighbours. */
const NeuralEmblem = ({ size = 34 }) => (
  <svg width={size} height={size} viewBox="0 0 48 48" style={{ flex: 'none', filter: 'drop-shadow(0 0 8px rgba(199,92,110,0.25))' }} aria-label="Kamilla Gafurzianova neural mark">
    <path fill="none" stroke="rgba(217,184,245,0.5)" strokeWidth="1" d="M11 14 L35 11 L39.5 27 L26.5 39.5 L9.5 31 Z" />
    <g stroke="rgba(217,184,245,0.55)" strokeWidth="1">
      <line x1="24" y1="23.5" x2="11" y2="14" /><line x1="24" y1="23.5" x2="35" y2="11" />
      <line x1="24" y1="23.5" x2="39.5" y2="27" /><line x1="24" y1="23.5" x2="26.5" y2="39.5" />
      <line x1="24" y1="23.5" x2="9.5" y2="31" />
    </g>
    <circle cx="11" cy="14" r="6" fill="#924bb2" opacity="0.22" /><circle cx="35" cy="11" r="6.5" fill="#c75c6e" opacity="0.22" />
    <circle cx="39.5" cy="27" r="5.5" fill="#d9b8f5" opacity="0.22" /><circle cx="26.5" cy="39.5" r="6" fill="#c75c6e" opacity="0.22" />
    <circle cx="9.5" cy="31" r="5.5" fill="#d9b8f5" opacity="0.22" /><circle cx="24" cy="23.5" r="9" fill="#f6b187" opacity="0.3" />
    <circle cx="11" cy="14" r="2.6" fill="#924bb2" /><circle cx="35" cy="11" r="3" fill="#c75c6e" />
    <circle cx="39.5" cy="27" r="2.4" fill="#d9b8f5" /><circle cx="26.5" cy="39.5" r="2.8" fill="#c75c6e" />
    <circle cx="9.5" cy="31" r="2.4" fill="#d9b8f5" /><circle cx="24" cy="23.5" r="3.8" fill="#f6b187" />
    <circle cx="24" cy="23.5" r="1.5" fill="#fff" opacity="0.85" />
  </svg>
);
const LogoMark = ({ size = 34, wordmark = true, compact = false }) => {
  if (compact) return <NeuralEmblem size={size} />;
  return (
    <span style={{ display: 'inline-flex', alignItems: 'center', gap: 12 }}>
      <NeuralEmblem size={size} />
      {wordmark && (
        <span style={{ display: 'flex', flexDirection: 'column', lineHeight: 1.12 }}>
          <span style={{ fontFamily: 'var(--font-display)', fontWeight: 700, fontSize: 16, letterSpacing: '-0.01em' }}>Kamilla Gafurzianova<span style={{ color: 'var(--accent-secondary)', fontWeight: 600 }}>,&nbsp;OLY</span></span>
          <span style={{ fontFamily: 'var(--font-mono)', fontSize: 9.5, letterSpacing: '0.14em', textTransform: 'uppercase', color: 'var(--text-muted)' }}>AI Implementation Consultant</span>
        </span>
      )}
    </span>
  );
};

const Btn = ({ variant = 'primary', size = 'md', icon, iconRight, children, ...p }) => (
  <button className={`btn btn--${variant} ${size === 'lg' ? 'btn--lg' : size === 'sm' ? 'btn--sm' : ''}`} {...p}>
    {icon && <I name={icon} size={15} />}{children}{iconRight && <I name={iconRight} size={15} />}
  </button>
);

const Chip = ({ children, variant }) => <span className={`chip ${variant ? 'chip--' + variant : ''}`}>{children}</span>;
const DOMAIN_ICON = { ai: 'brain-circuit', bizops: 'workflow', marketing: 'megaphone', community: 'users', sport: 'medal', education: 'graduation-cap', research: 'flask-conical' };
const DomainTag = ({ domain, children }) => <span className={`dtag dtag--${domain}`}><I name={DOMAIN_ICON[domain] || 'circle'} size={13} />{children || domain}</span>;
const PBadge = ({ p, children }) => <span className={`pbadge pbadge--${p}`}>{children}</span>;
const Node = ({ kind = '', size }) => <span className={`node ${kind ? 'node--' + kind : ''} ${size ? 'node--' + size : ''}`} />;

/* ---------- Navigation (sticky, blurred, with theme toggle) ---------- */
const Nav = ({ links, active, onNav, theme, onTheme }) => {
  const [scrolled, setScrolled] = React.useState(false);
  React.useEffect(() => {
    const h = () => setScrolled((document.scrollingElement || document.documentElement).scrollTop > 20);
    window.addEventListener('scroll', h, true);
    return () => window.removeEventListener('scroll', h, true);
  }, []);
  return (
    <header style={{
      position: 'sticky', top: 0, zIndex: 60, width: '100%',
      borderBottom: '1px solid var(--border-color)',
      background: scrolled ? 'color-mix(in srgb, var(--bg-color) 82%, transparent)' : 'transparent',
      backdropFilter: scrolled ? 'var(--backdrop-blur)' : 'none', transition: 'background .3s ease, backdrop-filter .3s ease',
    }}>
      <div style={{ maxWidth: 'var(--measure)', margin: '0 auto', padding: '14px 32px', display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 24 }}>
        <LogoMark />
        <nav style={{ display: 'flex', gap: 26 }} className="nav-links">
          {links.map(l => (
            <a key={l.id} href={`#${l.id}`} onClick={(e) => { e.preventDefault(); onNav(l.id); }}
              style={{ fontFamily: 'var(--font-mono)', fontSize: 12, fontWeight: 600, textTransform: 'uppercase', letterSpacing: '0.1em',
                color: active === l.id ? 'var(--accent-secondary)' : 'var(--text-muted)', cursor: 'pointer', transition: 'color .2s' }}>
              {l.label}
            </a>
          ))}
        </nav>
        <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
          <button onClick={onTheme} title="Toggle theme" className="btn btn--ghost btn--sm" style={{ padding: 8 }}>
            <I name={theme === 'theme-neural' ? 'sun' : 'moon'} size={16} />
          </button>
          <Btn variant="primary" size="sm" iconRight="arrow-up-right">Connect</Btn>
        </div>
      </div>
    </header>
  );
};

/* ---------- Footer ---------- */
const Footer = () => (
  <footer style={{ borderTop: '1px solid var(--border-color)', background: 'var(--bg-deep)', marginTop: 40 }}>
    <div style={{ maxWidth: 'var(--measure)', margin: '0 auto', padding: '32px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: 20, flexWrap: 'wrap' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
        <span style={{ width: 44, height: 44, borderRadius: '50%', background: 'linear-gradient(150deg,var(--accent-primary),#802338)', color: '#fff', display: 'grid', placeItems: 'center', fontFamily: 'var(--font-display)', fontWeight: 700, boxShadow: 'var(--glow-magenta)' }}>KG</span>
        <div style={{ display: 'flex', flexDirection: 'column' }}>
          <span style={{ fontWeight: 600, fontSize: 14, color: 'var(--text-primary)' }}>Kamilla Gafurzianova, OLY</span>
          <span style={{ fontSize: 12, color: 'var(--text-muted)', fontFamily: 'var(--font-mono)' }}>AI Implementation Consultant · Olympic Silver Medalist</span>
        </div>
      </div>
      <div style={{ display: 'flex', gap: 8 }}>
        {['linkedin', 'github', 'mail', 'globe'].map(ic => (
          <span key={ic} style={{ width: 38, height: 38, borderRadius: 'var(--radius-md)', border: '1px solid var(--border-color)', display: 'grid', placeItems: 'center', color: 'var(--text-secondary)', cursor: 'pointer', background: 'var(--glass-fill)' }}><I name={ic} size={16} /></span>
        ))}
      </div>
    </div>
    <div style={{ maxWidth: 'var(--measure)', margin: '0 auto', padding: '0 32px 26px', fontSize: 12, color: 'var(--text-faint)', fontFamily: 'var(--font-mono)' }}>
      © 2026 Kamilla Gafurzianova · Neural design system preview · integration over isolation.
    </div>
  </footer>
);

Object.assign(window, { I, Kicker, NeuralEmblem, LogoMark, Btn, Chip, DomainTag, PBadge, Node, Nav, Footer });
