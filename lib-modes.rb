######################################
# lib-modes.rb
# additional scales and chords
# based on scale_patch.rb from
# https://in-thread.sonic-pi.net/t/chord-progression-tool/4947/14
# author: Garen H.
#####################################

  class SonicPi::Scale
    
    def self.patch(scales)
      scales.each {|name, intervals|
       self::SCALE[name] = intervals unless self::SCALE.key? name
      }
    end

  end
  
  class SonicPi::Chord
    def self.patch(chords)
      chords.each { |name, intervals|
        unless self::CHORD.key? name.to_sym
          self::CHORD[name.to_sym] = intervals
          self::CHORD_LOOKUP[name.to_sym] = intervals
          self::CHORD_NAMES.append(name)
        end
      }
    end
  end

  class SonicPi::Modes
    def self.name_scales
      {
        :M7=>[:ionian, :lydian, :lydian2s, :ionian6b, :augmented],
        :minor7=>[:dorian, :phrygian, :aeolian, :phrygian6s, :dorian4s, :phrygian4b],
        '7'=>[:mixolydian, :mixolydian4s, :aeolian3s, :phrygian3s, :mixolydian2b, :diminished],
        'm7-5'=>[:locrian, :locrian2s, :ionian1s, :locrian6s, :dorian5b],
        'mM7'=>[:dorian7s, :aeolian7s, :lydian3b],
        :dim7=>[:mixolydian1s, :locrian7b, :aeolian1b, :diminished],
        'maj7+5'=>[:lydian5s, :ionian5s, :aeolian1b],
        '7-5'=>[:whole_tone],
        '7+5'=>[:whole_tone],
        '6+5'=>[:augmented2],
        # Other altered chords
        '7-5-3'=>[:ionian1],
        'm7+5'=>[:ionian1],
        '9'=>[:ionian1]
      }
    end
  end

  #Missing scales based on: https://www.newjazz.dk/Compendiums/scales_of_harmonies.pdf
  scales = lambda {
    ionian1s = [1,2,1,2,2,2,2]
    ionian5s = [2,2,1,3,1,2,1]
    ionian6b = [2,2,1,2,1,3,1]
    {
      # Family 1 - Major Modes (already exist in SPi)
      # :ionian
      # :dorian
      # :phrygian
      # :lydian
      # :mixolydian
      # :aeolian
      # :locrian
      # Family 2 - Melodic Minor Modes
      :ionian1s=>ionian1s,
      :dorian7s=>ionian1s.rotate(1),
      :phrygian6s=>ionian1s.rotate(2),
      :lydian5s=>ionian1s.rotate(3),
      :mixolydian4s=>ionian1s.rotate(4),
      :aeolian3s=>ionian1s.rotate(5),
      :locrian2s=>ionian1s.rotate(6),
      # Family 3 - Harmonic Minor Modes
      :ionian5s=>ionian5s,
      :dorian4s=>ionian5s.rotate(1),
      :phrygian3s=>ionian5s.rotate(2),
      :lydian2s=>ionian5s.rotate(3),
      :mixolydian1s=>ionian5s.rotate(4),
      :aeolian7s=>ionian5s.rotate(5),
      :locrian6s=>ionian5s.rotate(6),
      # Family 4 - Harmonic Major Modes
      :ionian6b=>ionian6b,
      :dorian5b=>ionian6b.rotate(1),
      :phrygian4b=>ionian6b.rotate(2),
      :lydian3b=>ionian6b.rotate(3),
      :mixolydian2b=>ionian6b.rotate(4),
      :aeolian1b=>ionian6b.rotate(5),
      :locrian7b=>ionian6b.rotate(6),
    }
  }.call
  
  chords = {
    # https://en.wikipedia.org/wiki/Minor_major_seventh_chord
    'mM7'=> [0, 3, 7, 11],
    # https://en.wikipedia.org/wiki/Augmented_major_seventh_chord
    'maj7+5'=> [0, 4, 8, 11],
    '6+5'=> [0, 4, 8, 9],
    # Missing altered chords: https://en.wikipedia.org/wiki/Altered_chord
    '7-5-3'=>[0, 3, 6, 10],
    '7+5+9'=>[0, 4, 8, 10, 14],
    '7-5-9'=>[0, 4, 6, 10, 13],
    '7-5+9'=>[0, 4, 6, 10, 14]
  
  }
  
  SonicPi::Scale.patch(scales)
  SonicPi::Chord.patch(chords)

