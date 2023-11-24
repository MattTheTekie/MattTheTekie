import { type ReactNode, useState, useEffect, useRef, type ElementType } from 'react'
import * as Icons from 'react-icons/fa'

interface DropdownProps {
  children: ReactNode
  icon: string
  direction?: 'left' | 'right'
}

export default function Dropdown ({ children, direction, icon }: DropdownProps): ReactNode {
  const [isOpen, setIsOpen] = useState(false)
  const containerRef = useRef<HTMLDivElement>(null)
  const buttonRef = useRef<HTMLButtonElement>(null)

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent): void => {
      if ((containerRef.current != null) && !containerRef.current.contains(event.target as Node) && (buttonRef.current != null) && !buttonRef.current.contains(event.target as Node)) {
        setIsOpen(false)
      }
    }

    document.addEventListener('mousedown', handleClickOutside)

    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
    }
  }, [])

  // @ts-expect-error - I can use string as index.
  const Icon = Icons[icon] as ElementType

  return (
    <div className='relative inline-block text-left'>
      <div>
        <button
          id='options-menu'
          type='button'
          className='p-2 bg-neutral-800 rounded-sm hover:brightness-75 transition duration-150 ease-in-out'
          aria-haspopup='true'
          aria-expanded='true'
          onClick={() => { setIsOpen(!isOpen) }}
          ref={buttonRef}
          aria-label='Options'
          name='Options'
        >
          <Icon size={18} />
        </button>
      </div>
      <div
        data-open={isOpen}
        data-direction={direction ?? 'left'}
        className='absolute mt-2 data-[open=true]:flex hidden bg-neutral-800 rounded-sm shadow-black shadow-lg p-4 border border-stone-600 min-w-7xl data-[direction=right]:origin-top-right data-[direction=right]:right-0 data-[direction=left]:origin-top-left data-[direction=left]:left-0 z-10'
        role='menu'
        aria-orientation='vertical'
        aria-labelledby='options-menu'
        ref={containerRef}
      >
        <div className='py-1' role='none'>
          {children}
        </div>
      </div>
    </div>
  )
}