module ApplicationHelper


  # NÃO ESTÁ FUNCIONANDO POIS O CINZA ESTÁ SOBRESCREVENDO NO FINAL
  def type_color(type)
    if type.downcase.include?("grass") or type.downcase.include?("bug")
      "border-success"
    elsif type.downcase.include?("electric")
      "border-warning"
    elsif type.downcase.include?("fire")
      "border-danger"
    elsif type.downcase.include?("water") or type.downcase.include?("ice")
      "border-info"
    elsif type.downcase.include?("fairy")
      "border-fairy"
    elsif type.downcase.include?("poison")
      "border-poison"
    elsif type.downcase.include?("ground") or type.downcase.include?("fighting")
      "border-warning-subtle"
    end
  end
end
