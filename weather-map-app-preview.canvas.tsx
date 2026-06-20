import { Stack, Row, Grid, Text, H1, H2, Card, CardBody, useHostTheme } from 'qoder/canvas';

export default function WeatherMapAppPreview() {
  const { tokens } = useHostTheme();

  return (
    <Stack gap={24}>
      {/* Header */}
      <Stack gap={8} align="center">
        <H1>Aplikasi Cuaca & Peta</H1>
        <Text tone="secondary" size="base">
          Flutter + Open-Meteo + OpenStreetMap
        </Text>
      </Stack>

      {/* Phone Mockups */}
      <Grid columns={2} gap={32}>
        {/* LEFT PHONE - Weather Tab */}
        <Stack gap={12}>
          <H2>Tab Cuaca</H2>
          <div style={{
            width: '100%',
            maxWidth: 360,
            aspectRatio: '9/16',
            background: tokens.bg.elevated,
            borderRadius: tokens.radius.xl,
            border: `2px solid ${tokens.stroke.secondary}`,
            overflow: 'hidden',
            display: 'flex',
            flexDirection: 'column',
          }}>
            {/* Status Bar */}
            <div style={{
              padding: '8px 16px',
              background: tokens.accent.control,
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center',
            }}>
              <Text size="xs" tone="secondary">14:30</Text>
              <Text size="xs" tone="secondary">● ● ●</Text>
            </div>

            {/* Search Bar */}
            <div style={{ padding: '12px 16px' }}>
              <div style={{
                padding: '10px 16px',
                background: tokens.fill.tertiary,
                borderRadius: tokens.radius.md,
                display: 'flex',
                alignItems: 'center',
                gap: 8,
              }}>
                <span style={{ fontSize: 16 }}>🔍</span>
                <Text tone="tertiary" size="sm">Cari kota...</Text>
              </div>
            </div>

            {/* Weather Card */}
            <div style={{ padding: '0 16px' }}>
              <div style={{
                padding: 20,
                background: `linear-gradient(135deg, ${tokens.chart.blue} 0%, ${tokens.chart.lightBlue} 100%)`,
                borderRadius: tokens.radius.lg,
                color: tokens.text.onAccent,
              }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 4, marginBottom: 12 }}>
                  <span>📍</span>
                  <Text size="sm" weight="medium" style={{ color: tokens.text.onAccent }}>
                    Jakarta, Indonesia
                  </Text>
                </div>

                <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
                  <span style={{ fontSize: 48 }}>🌤️</span>
                  <div>
                    <div style={{ fontSize: 36, fontWeight: 700, lineHeight: 1 }}>32.5°C</div>
                    <Text size="sm" style={{ color: 'rgba(255,255,255,0.8)' }}>Cerah Berawan</Text>
                  </div>
                </div>

                <div style={{
                  display: 'flex',
                  justifyContent: 'space-around',
                  marginTop: 16,
                  paddingTop: 16,
                  borderTop: '1px solid rgba(255,255,255,0.2)',
                }}>
                  <div style={{ textAlign: 'center' }}>
                    <div style={{ fontSize: 16 }}>💧</div>
                    <Text size="xs" weight="semibold" style={{ color: tokens.text.onAccent }}>78%</Text>
                    <Text size="xs" style={{ color: 'rgba(255,255,255,0.7)' }}>Kelembaban</Text>
                  </div>
                  <div style={{ textAlign: 'center' }}>
                    <div style={{ fontSize: 16 }}>💨</div>
                    <Text size="xs" weight="semibold" style={{ color: tokens.text.onAccent }}>12.3 km/h</Text>
                    <Text size="xs" style={{ color: 'rgba(255,255,255,0.7)' }}>Angin</Text>
                  </div>
                  <div style={{ textAlign: 'center' }}>
                    <div style={{ fontSize: 16 }}>🕐</div>
                    <Text size="xs" weight="semibold" style={{ color: tokens.text.onAccent }}>14:30</Text>
                    <Text size="xs" style={{ color: 'rgba(255,255,255,0.7)' }}>Waktu</Text>
                  </div>
                </div>
              </div>
            </div>

            {/* Forecast Section */}
            <div style={{ padding: '16px 16px 12px' }}>
              <Text size="base" weight="semibold">Prakiraan 7 Hari</Text>
            </div>

            <div style={{
              padding: '0 16px',
              display: 'flex',
              gap: 8,
              overflowX: 'auto',
            }}>
              {[
                { day: 'Sen', icon: '☀️', max: 34, min: 26 },
                { day: 'Sel', icon: '🌤️', max: 33, min: 25 },
                { day: 'Rab', icon: '⛈️', max: 31, min: 24 },
                { day: 'Kam', icon: '🌧️', max: 29, min: 23 },
                { day: 'Jum', icon: '🌦️', max: 30, min: 24 },
                { day: 'Sab', icon: '☁️', max: 32, min: 25 },
                { day: 'Min', icon: '☀️', max: 34, min: 26 },
              ].map((f) => (
                <div key={f.day} style={{
                  minWidth: 64,
                  padding: '12px 8px',
                  background: tokens.bg.panel,
                  borderRadius: tokens.radius.md,
                  border: `1px solid ${tokens.stroke.quaternary}`,
                  textAlign: 'center',
                  display: 'flex',
                  flexDirection: 'column',
                  alignItems: 'center',
                  gap: 6,
                }}>
                  <Text size="xs" weight="semibold">{f.day}</Text>
                  <span style={{ fontSize: 24 }}>{f.icon}</span>
                  <div>
                    <Text size="xs" weight="bold" style={{ color: tokens.chart.red }}>{f.max}°</Text>
                    <Text size="xs" style={{ color: tokens.chart.blue }}>{f.min}°</Text>
                  </div>
                </div>
              ))}
            </div>

            {/* Bottom Nav */}
            <div style={{
              marginTop: 'auto',
              padding: '12px 0',
              borderTop: `1px solid ${tokens.stroke.tertiary}`,
              display: 'flex',
              justifyContent: 'space-around',
            }}>
              <div style={{ textAlign: 'center' }}>
                <span style={{ fontSize: 20 }}>☁️</span>
                <Text size="xs" weight="semibold" style={{ color: tokens.accent.control }}>Cuaca</Text>
              </div>
              <div style={{ textAlign: 'center' }}>
                <span style={{ fontSize: 20 }}>🗺️</span>
                <Text size="xs" tone="tertiary">Peta</Text>
              </div>
            </div>
          </div>
        </Stack>

        {/* RIGHT PHONE - Map Tab */}
        <Stack gap={12}>
          <H2>Tab Peta</H2>
          <div style={{
            width: '100%',
            maxWidth: 360,
            aspectRatio: '9/16',
            background: tokens.bg.elevated,
            borderRadius: tokens.radius.xl,
            border: `2px solid ${tokens.stroke.secondary}`,
            overflow: 'hidden',
            display: 'flex',
            flexDirection: 'column',
            position: 'relative',
          }}>
            {/* Status Bar */}
            <div style={{
              padding: '8px 16px',
              background: tokens.accent.control,
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center',
              zIndex: 10,
            }}>
              <Text size="xs" tone="secondary">14:30</Text>
              <Text size="xs" tone="secondary">● ● ●</Text>
            </div>

            {/* Map Area */}
            <div style={{
              flex: 1,
              background: `linear-gradient(180deg, #e8f4e8 0%, #f5f0e0 50%, #e8e8f0 100%)`,
              position: 'relative',
            }}>
              {/* Grid lines for map feel */}
              <svg style={{ position: 'absolute', inset: 0, width: '100%', height: '100%', opacity: 0.15 }}>
                <line x1="0" y1="25%" x2="100%" y2="25%" stroke="#666" strokeWidth="1" />
                <line x1="0" y1="50%" x2="100%" y2="50%" stroke="#666" strokeWidth="1" />
                <line x1="0" y1="75%" x2="100%" y2="75%" stroke="#666" strokeWidth="1" />
                <line x1="25%" y1="0" x2="25%" y2="100%" stroke="#666" strokeWidth="1" />
                <line x1="50%" y1="0" x2="50%" y2="100%" stroke="#666" strokeWidth="1" />
                <line x1="75%" y1="0" x2="75%" y2="100%" stroke="#666" strokeWidth="1" />
                {/* Roads */}
                <line x1="10%" y1="30%" x2="90%" y2="30%" stroke="#888" strokeWidth="3" />
                <line x1="40%" y1="10%" x2="40%" y2="90%" stroke="#888" strokeWidth="3" />
                <line x1="20%" y1="60%" x2="80%" y2="60%" stroke="#888" strokeWidth="2" />
                <line x1="60%" y1="20%" x2="60%" y2="80%" stroke="#888" strokeWidth="2" />
              </svg>

              {/* Instruction Banner */}
              <div style={{
                position: 'absolute',
                top: 12,
                left: 12,
                right: 80,
                padding: '8px 12px',
                background: 'rgba(255,255,255,0.9)',
                borderRadius: tokens.radius.md,
                textAlign: 'center',
              }}>
                <Text size="xs">Tap peta untuk melihat cuaca</Text>
              </div>

              {/* FAB Buttons */}
              <div style={{
                position: 'absolute',
                top: 12,
                right: 12,
                display: 'flex',
                flexDirection: 'column',
                gap: 8,
              }}>
                {[
                  { icon: '📍', size: 40 },
                  { icon: '+', size: 32 },
                  { icon: '−', size: 32 },
                ].map((btn, i) => (
                  <div key={i} style={{
                    width: btn.size,
                    height: btn.size,
                    background: tokens.bg.elevated,
                    borderRadius: tokens.radius.full,
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    border: `1px solid ${tokens.stroke.tertiary}`,
                    fontSize: btn.size === 40 ? 18 : 16,
                    fontWeight: 600,
                  }}>
                    {btn.icon}
                  </div>
                ))}
              </div>

              {/* Current Location Marker */}
              <div style={{
                position: 'absolute',
                top: '45%',
                left: '45%',
                width: 32,
                height: 32,
                borderRadius: '50%',
                background: 'rgba(66, 133, 244, 0.3)',
                border: '3px solid #4285f4',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
              }}>
                <div style={{
                  width: 12,
                  height: 12,
                  borderRadius: '50%',
                  background: '#4285f4',
                }} />
              </div>

              {/* Selected Location Marker */}
              <div style={{
                position: 'absolute',
                top: '35%',
                left: '60%',
                fontSize: 32,
                transform: 'translate(-50%, -100%)',
                filter: 'drop-shadow(0 2px 4px rgba(0,0,0,0.3))',
              }}>
                📍
              </div>

              {/* Bottom Sheet */}
              <div style={{
                position: 'absolute',
                bottom: 0,
                left: 0,
                right: 0,
                padding: 20,
                background: tokens.bg.elevated,
                borderTopLeftRadius: tokens.radius.xl,
                borderTopRightRadius: tokens.radius.xl,
                borderTop: `1px solid ${tokens.stroke.tertiary}`,
              }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 12 }}>
                  <Text size="sm" weight="semibold">-6.21, 106.85</Text>
                  <span style={{ fontSize: 16, cursor: 'pointer' }}>✕</span>
                </div>

                <div style={{ display: 'flex', alignItems: 'center', gap: 16, marginBottom: 12 }}>
                  <span style={{ fontSize: 40 }}>🌤️</span>
                  <div>
                    <div style={{ fontSize: 28, fontWeight: 700, color: tokens.text.primary }}>29.8°C</div>
                    <Text size="sm" tone="secondary">Berawan</Text>
                  </div>
                </div>

                <div style={{ display: 'flex', gap: 8 }}>
                  <div style={{
                    padding: '6px 12px',
                    background: tokens.fill.tertiary,
                    borderRadius: tokens.radius.full,
                    display: 'flex',
                    alignItems: 'center',
                    gap: 4,
                  }}>
                    <span>💧</span>
                    <Text size="xs">78%</Text>
                  </div>
                  <div style={{
                    padding: '6px 12px',
                    background: tokens.fill.tertiary,
                    borderRadius: tokens.radius.full,
                    display: 'flex',
                    alignItems: 'center',
                    gap: 4,
                  }}>
                    <span>💨</span>
                    <Text size="xs">10.5 km/h</Text>
                  </div>
                </div>
              </div>
            </div>

            {/* Bottom Nav */}
            <div style={{
              padding: '12px 0',
              borderTop: `1px solid ${tokens.stroke.tertiary}`,
              display: 'flex',
              justifyContent: 'space-around',
            }}>
              <div style={{ textAlign: 'center' }}>
                <span style={{ fontSize: 20 }}>☁️</span>
                <Text size="xs" tone="tertiary">Cuaca</Text>
              </div>
              <div style={{ textAlign: 'center' }}>
                <span style={{ fontSize: 20 }}>🗺️</span>
                <Text size="xs" weight="semibold" style={{ color: tokens.accent.control }}>Peta</Text>
              </div>
            </div>
          </div>
        </Stack>
      </Grid>

      {/* Features Summary */}
      <Stack gap={12}>
        <H2>Fitur Utama</H2>
        <Grid columns={3} gap={16}>
          <Card>
            <CardBody>
              <Stack gap={8}>
                <span style={{ fontSize: 24 }}>🌡️</span>
                <Text weight="semibold" size="sm">Cuaca Real-time</Text>
                <Text size="xs" tone="secondary">Data dari Open-Meteo API tanpa API key</Text>
              </Stack>
            </CardBody>
          </Card>
          <Card>
            <CardBody>
              <Stack gap={8}>
                <span style={{ fontSize: 24 }}>🗺️</span>
                <Text weight="semibold" size="sm">Peta Interaktif</Text>
                <Text size="xs" tone="secondary">OpenStreetMap dengan tap untuk lihat cuaca</Text>
              </Stack>
            </CardBody>
          </Card>
          <Card>
            <CardBody>
              <Stack gap={8}>
                <span style={{ fontSize: 24 }}>📅</span>
                <Text weight="semibold" size="sm">Prakiraan 7 Hari</Text>
                <Text size="xs" tone="secondary">Prediksi cuaca seminggu ke depan</Text>
              </Stack>
            </CardBody>
          </Card>
        </Grid>
      </Stack>
    </Stack>
  );
}
