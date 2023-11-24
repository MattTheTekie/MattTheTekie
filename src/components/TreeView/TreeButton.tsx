import type { ButtonHTMLAttributes, ReactNode } from 'react'

type TreeButtonProps = {
  children?: ReactNode
} & ButtonHTMLAttributes<HTMLButtonElement>

export default function TreeButton ({
  children,
  ...props
}: TreeButtonProps): ReactNode {
  return (
    <button
      id='toggle'
      role='button'
      aria-label='Toggle'
      name='Toggle'
      className='flex items-center w-full'
      {...props}
    >
      {children}
    </button>
  )
}