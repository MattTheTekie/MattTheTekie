declare module '*.yaml' {
  const s: string
  export default s
}

declare module '@oruga-ui/oruga-next' {
  export const NotificationProgrammatic: {
    open(opts?: {
      message: string
      rootClass?: string
      position?: string
      duration?: number
    }): void
  }

  const d: any
  export default d
}
