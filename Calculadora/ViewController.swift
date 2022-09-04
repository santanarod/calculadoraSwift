//
//  ViewController.swift
//  Calculadora
//
//  Created by Allan Rodrigo Santana on 03/09/22.
//  Created by Osmair Luis Pereira on 03/09/22.
//  git@github.com:santanarod/calculadoraSwift.git

//Curso In-Company Bradesco - Visionnaire - PUCPR | Desenvolvimento de Software iOS
//Big Idea: Desenvolvimento de Apps
//• Essential Question: Como consolidar o conhecimento da primeira aula?
//• Challenge: Desenvolver uma calculadora simples


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var numeros: [UIButton]!
    @IBOutlet weak var display: UILabel!
    
    var displayNumero: Double = 0
    var entradaAnterior: Double?
    var resultadoOperacao: Double = 0
    var displayTexto = ""
    var operacaoMatematica: Int?
    var entradaNumericaAcionada: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var sequenciaButtons = 0
        for n in numeros {
            n.setTitle("\(sequenciaButtons)", for: .normal)
            n.tag = sequenciaButtons
            sequenciaButtons += 1
        }
        
        display.text! = "\(0)"
    }
    
    @IBAction func zerarValores(_ sender: UIButton) {
        entradaAnterior = nil
        displayNumero = 0
        displayTexto = ""
        display.text! = "\(0)"
    }
    
    @IBAction func registrarEntrada(_ sender: UIButton) {
        displayTexto += "\(sender.tag)"
        display.text! = displayTexto
        displayNumero = Double(displayTexto)!
        entradaNumericaAcionada = true
    }
    
    @IBAction func realizarOperacao(_ sender: UIButton) {
        operacaoMatematica = sender.tag
        calcular()
    }
    
    @IBAction func transformarDecimal(_ sender: UIButton) {
        if !display.text!.contains(".") {
            display.text! += "."
            displayTexto = display.text!
        }
    }
    
    //Exibe resultado da operação matemática quando o botão "=" é pressionado pelo usuário
    @IBAction func exibirResultado(_ sender: UIButton) {
        entradaNumericaAcionada = true
        calcular()
    }
    
    //Realiza a operação matemática e exibe o resultado ao usuário toda vez que um dos botões "/", "x", "-", "+" e "="é pressionado
    func calcular() {
        if operacaoMatematica != nil {
            if entradaNumericaAcionada {
                if let numeroAnterior = entradaAnterior {
                    resultadoOperacao = obterValores(n1: numeroAnterior, n2: displayNumero, operacao: operacaoMatematica!)
                    
                } else {
                    resultadoOperacao = displayNumero
                }
                
                entradaAnterior = resultadoOperacao
                display.text! = String(format: "%g", resultadoOperacao)
                displayTexto = ""
                entradaNumericaAcionada = false
            }
            
        } else {
            displayTexto = ""
            entradaNumericaAcionada = false
        }
    }
    
    func obterValores(n1: Double, n2: Double, operacao: Int) -> Double {
        switch operacao {
        case 20:
            return n1 / n2
        case 21:
            return n1 * n2
        case 22:
            return n1 - n2
        default:
            return n1 + n2
        }
    }
}
