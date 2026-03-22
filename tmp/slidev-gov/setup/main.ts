import { defineAppSetup } from '@slidev/types'

export default defineAppSetup(({ app, router }) => {
  // inject global style
  if (typeof document !== 'undefined') {
    const style = document.createElement('style')
    style.textContent = `
      h1, h2, h3 {
        font-family: 'Arial Black', 'Arial Bold', Arial, sans-serif !important;
        font-weight: 900 !important;
        letter-spacing: -0.02em !important;
      }
    `
    document.head.appendChild(style)
  }
})
