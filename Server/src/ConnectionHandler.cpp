/**
 * @file ConnectionHandler.cpp
 * 
 * @brief Implementation of the ConnectionHandler class
 */

// SYSTEM INCLUDES
#include <iostream>
#include <boost/bind.hpp>
#include <string>
#include <vector>

// C++ PROJECT INCLUDES
#include "ConnectionHandler.hpp" // Header for class
#include "Request.hpp" // For Common::Request
#include "Response.hpp" // For Common::Response


void ConnectionHandler::Start()
{
    m_socket.async_read_some(boost::asio::buffer(m_data, ConnectionHandler::MAX_LENGTH),
                             boost::bind(&ConnectionHandler::HandleRead,
                             shared_from_this(),
                             boost::asio::placeholders::error,
                             boost::asio::placeholders::bytes_transferred));
}

void ConnectionHandler::HandleRead(const boost::system::error_code& rErr, size_t bytesTransferred)
{
    if (rErr)
    {
        std::cerr << "error: " << rErr.message() << std::endl;
        m_socket.close();
        return;
    }

    // Terminate what was transferred
    m_data[bytesTransferred] = '\0';

    // Just print out the received data
    std::cout << "Server received " << m_data << std::endl;

    // Parse the data into the request structure
    Common::Request req;
    ParseRequest(req);

    // Determine what needs done for this request
    HandleRequest(req);

    m_socket.async_write_some(boost::asio::buffer(m_message, ConnectionHandler::MAX_LENGTH),
                              boost::bind(&ConnectionHandler::HandleWrite,
                              shared_from_this(),
                              boost::asio::placeholders::error,
                              boost::asio::placeholders::bytes_transferred));
}

void ConnectionHandler::HandleWrite(const boost::system::error_code& rErr, size_t bytesTransferred)
{
    if (!rErr)
    {
        // Just print out a message
        std::cout << "Server sent %s" << m_message.c_str() << std::endl;
    }
    else
    {
        std::cerr << "error: " << rErr.message() << std::endl;
        m_socket.close();
    }
}

void ConnectionHandler::ParseRequest(Common::Request& rReq)
{
    try
    {
        // Convert data to an string
        std::string data = std::string(m_data);

        std::string requestCode = "";
        std::string additionalData = "";
        if (data.find_first_of(" ") == std::string::npos)
        {
            requestCode = data;
        }
        else
        {
            requestCode = data.substr(0, data.find_first_of(" "));
            additionalData = data.substr(data.find_first_of(" ") + 1);
        }

        // First characters should be the request code
        rReq.SetRequestCode(static_cast<Common::RequestCode>(std::stoi(requestCode)));

        // Place the additional data into the data field of the request
        rReq.SetData(additionalData);
    }
    catch (std::exception& e)
    {
        std::cout << "Invalid command " << m_data << std::endl;
        rReq.SetRequestCode(Common::RequestCode::ERROR);
    }
}

void ConnectionHandler::HandleRequest(Common::Request& rReq)
{
    Common::Response resp;

    // Return early if the request code is ERROR
    if (rReq.GetRequestCode() == Common::RequestCode::ERROR)
    {
        resp.SetResponseCode(Common::ResponseCode::ERROR);
        m_message = resp.ToString();
        return;
    }

     switch (rReq.GetRequestCode())
     {
         case Common::RequestCode::REPORT:
        {
            break;
        }
         default:
             std::cout << "Invalid RequestCode " << static_cast<int>(rReq.GetRequestCode()) << std::endl;
             resp.SetResponseCode(Common::ResponseCode::ERROR);
             break;
     }

    // Set the message, so the requester will receive the response
    // m_message = resp.ToString();
}
