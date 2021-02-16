def ceasar(string,shift)

  #  put string in array of ascii codes and 
 string.codepoints.map do |num| 
              # apply shift to each character

              # not character - don't shift
              if num.chr.match(/\W/)
                shifted_code = num
              else
                # get modulus to deal with large shifts
                shifted_code = num + shift % 26

                # wrap if out of lower case range
                if num >= 97 && num <= 122
                  shifted_code > 122 ? shifted_code -= 26 : shifted_code
                  shifted_code < 97 ? shifted_code += 26 : shifted_code
                end

                # wrap if out of upper case range
                if num >= 65 && num <= 90
                  shifted_code > 90 ? shifted_code -= 26 : shifted_code
                  shifted_code < 65 ? shifted_code += 26 : shifted_code
                end

              end
              # convert back to characters
              shifted_code.chr

            end
            # convert back to string
            .join
end

p ceasar("What a String!",-25)